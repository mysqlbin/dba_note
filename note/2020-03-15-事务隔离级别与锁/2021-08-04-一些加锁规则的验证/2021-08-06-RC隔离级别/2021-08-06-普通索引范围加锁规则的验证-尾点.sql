

1. 表结构和数据的初始化
2. RC隔离级别
	2.0 用 lock in share mode和for update语句做验证
	2.1 等值范围查询--先根据二级索引删除数据再等值范围查询加锁
	2.2 等值范围查询--先根据二级索引等值范围查询加锁再删除数据
	2.3 等值范围查询--先根据主键索引删除数据再等值范围查询加锁
	2.4 等值范围查询--先根据主键索引更新数据再等值范围查询加锁
	
	
	
	----------------------------------------------------------
	
	2.5 范围查询--先根据二级索引删除数据再范围查询加锁
	2.6 范围查询--先范围查询加锁再根据二级索引删除数据
	2.7 范围查询--先范围查询加锁再根据主键索引删除数据
	2.8 范围查询--先范围查询加锁再根据主键索引更新数据
	2.9 范围查询--先根据主键索引更新数据再范围查询加锁
	2.10 范围查询--先根据主键索引更新数据再范围查询加锁

	
3.0 用update和delete语句做验证
	3.1 等值范围更新--先根据二级索引删除数据再等值范围更新加锁
	3.2 等值范围删除--先根据二级索引删除数据再等值范围删除加锁
	3.3 等值范围删除--先根据主键索引删除数据再等值范围删除加锁
	3.4 等值范围更新--先根据主键索引删除数据再等值范围更新加锁
	3.5 等值范围更新--先对主键索引的记录加锁再等值范围更新加锁
	3.6 等值范围更新--先根据主键索引更新数据再等值范围更新加锁
	3.6.2 等值范围更新--先等值范围更新加锁再根据主键索引更新数据
	3.6.3 等值范围更新--先等值范围更新加锁再根据二级索引更新数据

	----------------------------------------------------------
	
	3.7 范围更新--先根据二级索引删除数据再范围更新加锁
	3.8 范围更新--先根据主键索引删除数据再范围更新加锁
	3.9 范围更新--先范围更新加锁再根据普通索引删除加锁
	3.10 范围更新--先根据主键索引更新数据再范围更新加锁		
	3.11 范围更新--先范围更新加锁再根据主键索引更新数据
	
	-- 验证delete
	3.12 范围更新--先根据普通索引删除数据再根据二级索引更新数据		
	3.13 范围更新--根据二级索引更新数据再根据普通索引删除数据

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
		
	call idata();

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
	

2.0 用 lock in share mode和for update语句做验证
	
	mysql> desc select * from t where c>=2 and  c<=3 lock in share mode;
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
	| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra                 |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
	|  1 | SIMPLE      | t     | NULL       | range | c             | c    | 5       | NULL |    2 |   100.00 | Using index condition |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
	1 row in set, 1 warning (0.00 sec)
	
	
	begin;
	select * from t where c>=2 and  c<=3 lock in share mode;
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1063:139834941305512  |       421310033308264 |        89 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139835056597608:6:5:3:139834941302472 |       421310033308264 |        89 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056597608:6:5:4:139834941302472 |       421310033308264 |        89 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056597608:6:5:5:139834941302472 |       421310033308264 |        89 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 4, 4      |
	| 139835056597608:6:4:3:139834941302816 |       421310033308264 |        89 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056597608:6:4:4:139834941302816 |       421310033308264 |        89 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	6 rows in set (0.00 sec)
	
	
	begin;
	select * from t where c>=2 and  c<=3 for update;
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1063:139834941305512  |                  3743 |        89 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:5:3:139834941302472 |                  3743 |        89 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056597608:6:5:4:139834941302472 |                  3743 |        89 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056597608:6:5:5:139834941302472 |                  3743 |        89 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	| 139835056597608:6:4:3:139834941302816 |                  3743 |        89 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056597608:6:4:4:139834941302816 |                  3743 |        89 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	6 rows in set (0.00 sec)


2.1 等值范围查询--先根据二级索引删除数据再等值范围查询加锁
	
	session A           session B	
	begin;
	delete from t where c=4;
	
						begin;
						select * from t where c>=2 and  c<=3 lock in share mode;
						(Blocked)	
										
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056598480:1063:139834941311464  |                  3709 |        79 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:6:5:5:139834941308536 |                  3709 |        79 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	| 139835056598480:6:4:5:139834941308880 |                  3709 |        79 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	
	| 139835056597608:1063:139834941305512  |       421310033308264 |        80 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139835056597608:6:5:3:139834941302472 |       421310033308264 |        80 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056597608:6:5:4:139834941302472 |       421310033308264 |        80 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056597608:6:4:3:139834941302816 |       421310033308264 |        80 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056597608:6:4:4:139834941302816 |       421310033308264 |        80 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 139835056597608:6:5:5:139834941303160 |       421310033308264 |        80 | t           | c          | RECORD    | S,REC_NOT_GAP | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)

	-- 普通索引的范围等值查询, 需要访问到不满足条件的第一个值为止, 并且需要加锁.
	
	
	------------------------------------------------------------------------------------------------------------------------------------------------------------
		
	session A           session B	
	begin;
	delete from t where c=4;
	
						begin;
						select * from t where c>=2 and  c<=3 for update;
						(Blocked)	
											
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140375342886352:1068:140375234775528   |                 53027 |        62 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140375342886352:11:5:3:140375234772600 |                 53027 |        62 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 140375342886352:11:5:4:140375234772600 |                 53027 |        62 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 140375342886352:11:4:3:140375234772944 |                 53027 |        62 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 140375342886352:11:4:4:140375234772944 |                 53027 |        62 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 140375342886352:11:5:5:140375234773288 |                 53027 |        62 | t           | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 4, 4      |
	-- 普通索引的范围等值查询, 需要访问到不满足条件的第一个值为止, 并且需要加锁.
	| 140375342885480:1068:140375234769576   |                 53022 |        63 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140375342885480:11:5:5:140375234766536 |                 53022 |        63 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	| 140375342885480:11:4:5:140375234766880 |                 53022 |        63 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)
											
										
2.2 等值范围查询--先根据二级索引等值范围查询加锁再删除数据
	
	session A		session B	
	begin;
	select * from t where c>=2 and  c<=3 lock in share mode;
	
	T1 
					begin;
					delete from t where c=4;
					(Blocked)	

	T2 
	
	T1时刻
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139835056597608:1063:139834941305512  |       421310033308264 |        84 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 139835056597608:6:5:3:139834941302472 |       421310033308264 |        84 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 2, 2      |
		| 139835056597608:6:5:4:139834941302472 |       421310033308264 |        84 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 3, 3      |
		| 139835056597608:6:5:5:139834941302472 |       421310033308264 |        84 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 4, 4      |
		| 139835056597608:6:4:3:139834941302816 |       421310033308264 |        84 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
		| 139835056597608:6:4:4:139834941302816 |       421310033308264 |        84 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		6 rows in set (0.00 sec)
	
	T2时刻
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139835056598480:1063:139834941311464  |                  3719 |        83 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139835056598480:6:5:5:139834941308536 |                  3719 |        83 | t           | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 4, 4      |
		-- 被二级索引 c=4 的记录锁阻塞。
		| 139835056597608:1063:139834941305512  |       421310033308264 |        84 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 139835056597608:6:5:3:139834941302472 |       421310033308264 |        84 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 2, 2      |
		| 139835056597608:6:5:4:139834941302472 |       421310033308264 |        84 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 3, 3      |
		| 139835056597608:6:5:5:139834941302472 |       421310033308264 |        84 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 4, 4      |
		| 139835056597608:6:4:3:139834941302816 |       421310033308264 |        84 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
		| 139835056597608:6:4:4:139834941302816 |       421310033308264 |        84 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		8 rows in set (0.00 sec)
	
	-- 普通索引的范围等值查询, 需要访问到不满足条件的第一个值为止, 并且需要加锁, 不会把不满足条件的锁释放掉.
	
	
	------------------------------------------------------------------------------------------------------------------------------------------------------------
		
	session A		session B	
	begin;
	select * from t where c>=2 and  c<=3 for update;
	
	T1 
					begin;
					delete from t where c=4;
					

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140375342886352:1068:140375234775528   |                 53021 |        62 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140375342886352:11:5:5:140375234772600 |                 53021 |        62 | t           | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	| 140375342885480:1068:140375234769576   |                 53020 |        63 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140375342885480:11:5:3:140375234766536 |                 53020 |        63 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 140375342885480:11:5:4:140375234766536 |                 53020 |        63 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 140375342885480:11:5:5:140375234766536 |                 53020 |        63 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	| 140375342885480:11:4:3:140375234766880 |                 53020 |        63 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 140375342885480:11:4:4:140375234766880 |                 53020 |        63 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	8 rows in set (0.00 sec)
					
	
2.3 等值范围查询--先根据主键索引删除数据再等值范围查询加锁

	session A           session B	
	begin;
	delete from t where id=4;

						begin;
						select * from t where c>=2 and  c<=3 lock in share mode;
						(Blocked)


	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1063:139834941305512  |                  3720 |        84 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:4:5:139834941302472 |                  3720 |        84 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	| 139835056597608:6:5:5:139834941302816 |                  3720 |        83 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	| 139835056598480:1063:139834941311464  |       421310033309136 |        83 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139835056598480:6:5:3:139834941308536 |       421310033309136 |        83 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056598480:6:5:4:139834941308536 |       421310033309136 |        83 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056598480:6:4:3:139834941308880 |       421310033309136 |        83 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056598480:6:4:4:139834941308880 |       421310033309136 |        83 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 139835056598480:6:5:5:139834941309224 |       421310033309136 |        83 | t           | c          | RECORD    | S,REC_NOT_GAP | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)
	
	-- 普通索引的范围等值查询, 需要访问到不满足条件的第一个值为止, 并且需要加锁.
	
	------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	session A           session B	
	begin;
	delete from t where id=4;

						begin;
						select * from t where c>=2 and  c<=3 for update;
						(Blocked)
						

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140375342886352:1068:140375234775528   |                 53018 |        62 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140375342886352:11:5:3:140375234772600 |                 53018 |        62 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 140375342886352:11:5:4:140375234772600 |                 53018 |        62 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 140375342886352:11:4:3:140375234772944 |                 53018 |        62 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 140375342886352:11:4:4:140375234772944 |                 53018 |        62 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 140375342886352:11:5:5:140375234773288 |                 53018 |        62 | t           | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	| 140375342885480:1068:140375234769576   |                 53017 |        63 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140375342885480:11:4:5:140375234766536 |                 53017 |        63 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	| 140375342885480:11:5:5:140375234766880 |                 53017 |        62 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)


2.4 等值范围查询--先根据主键索引更新数据再等值范围查询加锁
	session A           session B	
	begin;
	update t set d=100 where id=4;

						begin;
						select * from t where c>=2 and  c<=3 lock in share mode;
						(Query Ok)
						
	
------------------------------------------------------------------------------------------------------------------------------------------------------------

	session A           session B	
	begin;
	update t set d=100 where id=4;

						begin;
						select * from t where c>=2 and  c<=3 for update;
						(Query Ok)
						

------------------------------------------------------------------------------------------------------------------------------------------------------------
	
2.5 范围查询--先根据二级索引删除数据再范围查询加锁

	session A           session B	
	begin;
	delete from t where c=3;
	
						begin;
						select * from t where c>=2 and  c<3 lock in share mode;
						(Blocked)	
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056598480:1063:139834941311464  |                  3712 |        79 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:6:5:4:139834941308536 |                  3712 |        79 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056598480:6:4:4:139834941308880 |                  3712 |        79 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	
	| 139835056597608:1063:139834941305512  |       421310033308264 |        80 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139835056597608:6:5:3:139834941302472 |       421310033308264 |        80 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056597608:6:4:3:139834941302816 |       421310033308264 |        80 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056597608:6:5:4:139834941303160 |       421310033308264 |        80 | t           | c          | RECORD    | S,REC_NOT_GAP | WAITING     | 3, 3      |
	-- 被二级索引 c=3 的记录锁阻塞。
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.00 sec)
	
	-- 普通索引的范围查询, 需要访问到不满足条件的第一个值为止, 并且需要加锁, 不会把不满足条件的锁释放掉.


					
2.6 范围查询--先范围查询加锁再根据二级索引删除数据

	session A           session B	
	begin;
	select * from t where c>=2 and  c<3 lock in share mode;	
			
						begin;
						delete from t where c=3;
						(Blocked)
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056598480:1063:139834941311464  |                  3799 |       113 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:6:5:4:139834941308536 |                  3799 |       113 | t           | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 3, 3      |
	-- 被二级索引 c=3 的记录锁阻塞。
	| 139835056597608:1063:139834941305512  |       421310033308264 |       112 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139835056597608:6:5:3:139834941302472 |       421310033308264 |       112 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056597608:6:5:4:139834941302472 |       421310033308264 |       112 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056597608:6:4:3:139834941302816 |       421310033308264 |       112 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	6 rows in set (0.00 sec)
	
2.7 范围查询--先范围查询加锁再根据主键索引删除数据

	session A           session B	
	begin;
	select * from t where c>=2 and  c<3 lock in share mode;	
			
						begin;
						delete from t where id=3;	
						(Blocked)
	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056598480:1063:139834941311464  |                  3804 |       113 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:6:4:4:139834941308536 |                  3804 |       113 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139835056598480:6:5:4:139834941308880 |                  3804 |       113 | t           | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 3, 3      |
	-- 被二级索引 c=3 的记录锁阻塞。
	| 139835056597608:1063:139834941305512  |       421310033308264 |       112 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139835056597608:6:5:3:139834941302472 |       421310033308264 |       112 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056597608:6:5:4:139834941302472 |       421310033308264 |       112 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056597608:6:4:3:139834941302816 |       421310033308264 |       112 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.01 sec)

	

2.8 范围查询--先范围查询加锁再根据主键索引更新数据

	session A           session B	
	begin;
	select * from t where c>=2 and  c<3 lock in share mode;	
			
						begin;
						update t set d=100 where id=3;
						(Query Ok)



2.9 范围查询--先根据主键索引更新数据再范围查询加锁

	session A           session B	
	begin;
	update t set d=100 where id=3;
	
						begin;
						select * from t where c>=2 and  c<3 lock in share mode;	
						(Query Ok)
						
2.10 范围查询--先根据主键索引更新数据再范围查询加锁

	session A           session B	
	begin;
	update t set d=100 where id=3;
	
						begin;
						select * from t where c>=2 and  c<3 for update;	
						(Query Ok)	
						
--------------------------------------------------------------------------------------------------------------------------------------------------------------
	
3.0 用update和delete语句做验证

	update t set d=100 where c>=2 and  c<=3;
	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1063:139834941305512  |                  3729 |        89 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:5:3:139834941302472 |                  3729 |        89 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056597608:6:5:4:139834941302472 |                  3729 |        89 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056597608:6:4:3:139834941302816 |                  3729 |        89 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056597608:6:4:4:139834941302816 |                  3729 |        89 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	5 rows in set (0.00 sec)

	--------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	delete from t where c>=2 and  c<=3;
	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1063:139834941305512  |                  3772 |       100 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:5:3:139834941302472 |                  3772 |       100 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056597608:6:5:4:139834941302472 |                  3772 |       100 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056597608:6:4:3:139834941302816 |                  3772 |       100 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056597608:6:4:4:139834941302816 |                  3772 |       100 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	5 rows in set (0.00 sec)


3.1 等值范围更新--先根据二级索引删除数据再等值范围更新加锁
	
	session A           session B
	begin;
	delete from t where c=4;
						
						begin;
						update t set d=100 where c>=2 and  c<=3;
						(Blocked)

	root@mysqldb 15:53:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056598480:1063:139834941311464  |                  3732 |        91 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:6:5:3:139834941308536 |                  3732 |        91 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056598480:6:5:4:139834941308536 |                  3732 |        91 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056598480:6:4:3:139834941308880 |                  3732 |        91 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056598480:6:4:4:139834941308880 |                  3732 |        91 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139835056598480:6:5:5:139834941309224 |                  3732 |        91 | t           | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	| 139835056597608:1063:139834941305512  |                  3731 |        89 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:5:5:139834941302472 |                  3731 |        89 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	| 139835056597608:6:4:5:139834941302816 |                  3731 |        89 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)

	
3.2 等值范围删除--先根据二级索引删除数据再等值范围删除加锁

	session A           session B
	begin;
	delete from t where c=4;
						
						begin;
						delete from t where c>=2 and  c<=3;
						(Blocked)


	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056598480:1063:139834941311464  |                  3757 |        96 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:6:5:3:139834941308536 |                  3757 |        96 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056598480:6:5:4:139834941308536 |                  3757 |        96 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056598480:6:4:3:139834941308880 |                  3757 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056598480:6:4:4:139834941308880 |                  3757 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139835056598480:6:5:5:139834941309224 |                  3757 |        96 | t           | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	| 139835056597608:1063:139834941305512  |                  3756 |        95 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:5:5:139834941302472 |                  3756 |        95 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	| 139835056597608:6:4:5:139834941302816 |                  3756 |        95 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)


3.3 等值范围删除--先根据主键索引删除数据再等值范围删除加锁

	
	session A           session B
	begin;
	delete from t where id=4;
						
						begin;
						delete from t where c>=2 and  c<=3;
						(Blocked)


	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056598480:1063:139834941311464  |                  3765 |        96 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:6:5:3:139834941308536 |                  3765 |        96 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056598480:6:5:4:139834941308536 |                  3765 |        96 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056598480:6:4:3:139834941308880 |                  3765 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056598480:6:4:4:139834941308880 |                  3765 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139835056598480:6:5:5:139834941309224 |                  3765 |        96 | t           | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	| 139835056597608:1063:139834941305512  |                  3764 |        95 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:4:5:139834941302472 |                  3764 |        95 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	| 139835056597608:6:5:5:139834941302816 |                  3764 |        96 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)


3.4 等值范围更新--先根据主键索引删除数据再等值范围更新加锁
	
	session A           session B
	begin;
	delete from t where id=4;
						
						begin;
						update t set c=100 where c>=2 and  c<=3;
						(Blocked)
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1063:139834941305512  |                  3788 |       104 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:5:3:139834941302472 |                  3788 |       104 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056597608:6:5:4:139834941302472 |                  3788 |       104 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056597608:6:4:3:139834941302816 |                  3788 |       104 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056597608:6:4:4:139834941302816 |                  3788 |       104 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139835056597608:6:5:5:139834941303160 |                  3788 |       104 | t           | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	| 139835056598480:1063:139834941311464  |                  3783 |       105 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:6:4:5:139834941308536 |                  3783 |       105 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	| 139835056598480:6:5:5:139834941308880 |                  3783 |       104 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)
	
	session A语句持有的锁：
		primary key record lock: id=4
		c:record lock: c=4

3.5 等值范围更新--先对主键索引的记录加锁再等值范围更新加锁

	session A           session B
	begin;
	SELECT * FROM t WHERE id=4 FOR UPDATE;
	
						begin;
						update t set d=100 where c>=2 and  c<=3;
						(Blocked)
	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1063:139834941305512  |                  3791 |       104 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:5:3:139834941302472 |                  3791 |       104 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056597608:6:5:4:139834941302472 |                  3791 |       104 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056597608:6:5:5:139834941302472 |                  3791 |       104 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	| 139835056597608:6:4:3:139834941302816 |                  3791 |       104 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056597608:6:4:4:139834941302816 |                  3791 |       104 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139835056597608:6:4:5:139834941303160 |                  3791 |       104 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 4         |
	-- 被主键索引 id=4 的记录锁阻塞。
	| 139835056598480:1063:139834941311464  |                  3790 |       105 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:6:4:5:139834941308536 |                  3790 |       105 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)
	
		
	session A语句持有的锁：
		primary key record lock: id=4
		
	
	
3.6 等值范围更新--先根据主键索引更新数据再等值范围更新加锁

	session A           session B
	begin;
	update t set d=10 where id=4;
	--这里没有更新二级索引的记录
						begin;
						update t set d=100 where c>=2 and  c<=3;
						(Blocked)

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1063:139834941305512  |                  3794 |       104 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:5:3:139834941302472 |                  3794 |       104 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056597608:6:5:4:139834941302472 |                  3794 |       104 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056597608:6:5:5:139834941302472 |                  3794 |       104 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	| 139835056597608:6:4:3:139834941302816 |                  3794 |       104 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056597608:6:4:4:139834941302816 |                  3794 |       104 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139835056597608:6:4:5:139834941303160 |                  3794 |       104 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 4         |
	-- 被主键索引 id=4 的记录锁阻塞。
	| 139835056598480:1063:139834941311464  |                  3793 |       107 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:6:4:5:139834941308536 |                  3793 |       107 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)

	session A语句持有的锁：
		primary key record lock: id=4
	


3.6.2 等值范围更新--先等值范围更新加锁再根据主键索引更新数据

	session A           session B
	begin;
	update t set d=100 where c>=2 and  c<=3;


						update t set d=10 where id=4;
						(Query Ok)

3.6.3 等值范围更新--先等值范围更新加锁再根据二级索引更新数据

	session A           session B
	begin;
	update t set d=100 where c>=2 and  c<=3;


						update t set d=10 where c=4;
						(Query Ok)

						
3.7 范围更新--先根据二级索引删除数据再范围更新加锁
	
	begin;
	update t set d=100 where c>=2 and  c<3;	

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1063:139834941305512  |                  3814 |       118 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:5:3:139834941302472 |                  3814 |       118 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056597608:6:4:3:139834941302816 |                  3814 |       118 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	3 rows in set (0.00 sec)

	
	session A       session B
	begin;
	delete from t where c=3;


					begin;
					update t set d=100 where c>=2 and  c<3;
					(Blocked)
					
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056598480:1063:139834941311464  |                  3817 |       120 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:6:5:3:139834941308536 |                  3817 |       120 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056598480:6:4:3:139834941308880 |                  3817 |       120 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056598480:6:5:4:139834941309224 |                  3817 |       120 | t           | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 3, 3      |
	-- 被普通索引 c=3 的记录锁阻塞。
	| 139835056597608:1063:139834941305512  |                  3816 |       121 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:5:4:139834941302472 |                  3816 |       121 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056597608:6:4:4:139834941302816 |                  3816 |       121 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.00 sec)
		
	--------------------------------------------------------------------------------------------------------------------------------------------------------------

3.8 范围更新--先根据主键索引删除数据再范围更新加锁
	
	session A       session B
	begin;
	delete from t where id=3;


					begin;
					update t set d=100 where c>=2 and  c<3;
					(Blocked)
		
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056598480:1063:139834941311464  |                  3825 |       120 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:6:5:3:139834941308536 |                  3825 |       120 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056598480:6:4:3:139834941308880 |                  3825 |       120 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056598480:6:5:4:139834941309224 |                  3825 |       120 | t           | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 3, 3      |
	-- 被普通索引 c=3 的记录锁阻塞。
	| 139835056597608:1063:139834941305512  |                  3819 |       121 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:4:4:139834941302472 |                  3819 |       121 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139835056597608:6:5:4:139834941302816 |                  3819 |       120 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.00 sec)

3.9 范围更新--先范围更新加锁再根据普通索引删除加锁
	
	session A       session B
	begin;
	update t set d=100 where c>=2 and  c<3;

					begin;
					delete from t where c=3;
					(Query Ok)
					
					

3.10 范围更新--先根据主键索引更新数据再范围更新加锁


	session A       session B
	begin;
	update t set d=100 where id=3;

					begin;
					update t set d=100 where c>=2 and  c<3;
					(Blocked)
					
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056598480:1063:139834941311464  |                  3833 |       127 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:6:5:3:139834941308536 |                  3833 |       127 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056598480:6:5:4:139834941308536 |                  3833 |       127 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056598480:6:4:3:139834941308880 |                  3833 |       127 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056598480:6:4:4:139834941309224 |                  3833 |       127 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 3         |
	-- 被主键索引 id=3 的记录锁阻塞。
	| 139835056597608:1063:139834941305512  |                  3832 |       126 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:4:4:139834941302472 |                  3832 |       126 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.00 sec)
		

3.11 范围更新--先范围更新加锁再根据主键索引更新数据

	session A       session B
	begin;
	update t set d=100 where c>=2 and  c<3;
	
					begin;
					update t set d=100 where c=3;
					(Query Ok)


	
3.12 范围更新--先根据普通索引删除数据再根据二级索引更新数据
	
	session A       session B
	begin;
	delete from t where c>=2 and  c<3;
	
					begin;
					update t set d=100 where c=3;	
					(Query Ok)

					
	
3.13 范围更新--根据二级索引更新数据再根据普通索引删除数据
	
`	begin;
	update t set d=100 where c=3;	
					begin;
					delete from t where c>=2 and  c<3;
					(Blocked)
					
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140375342885480:1068:140375234769576   |                 53006 |        60 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140375342885480:11:5:3:140375234766536 |                 53006 |        60 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 140375342885480:11:4:3:140375234766880 |                 53006 |        60 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 140375342885480:11:5:4:140375234767224 |                 53006 |        60 | t           | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 3, 3      |
	| 140375342886352:1068:140375234775528   |                 53005 |        59 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140375342886352:11:5:4:140375234772600 |                 53005 |        59 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 140375342886352:11:4:4:140375234772944 |                 53005 |        59 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.00 sec)


					
4. 小结	
	4.1 各自的加锁规则 
		-- 仅供参考
		select * from t where c>=2 and  c<=3 lock in share mode;
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140483187886696:1068:140483078714024   |       421958164597352 |        58 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 140483187886696:11:5:3:140483078710984 |       421958164597352 |        58 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 2, 2      |
		| 140483187886696:11:5:4:140483078710984 |       421958164597352 |        58 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 3, 3      |
		| 140483187886696:11:5:5:140483078710984 |       421958164597352 |        58 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 4, 4      |
		| 140483187886696:11:4:3:140483078711328 |       421958164597352 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
		| 140483187886696:11:4:4:140483078711328 |       421958164597352 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		6 rows in set (0.01 sec)


		select * from t where c>=2 and  c<3 lock in share mode;
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140483187886696:1068:140483078714024   |       421958164597352 |        58 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 140483187886696:11:5:3:140483078710984 |       421958164597352 |        58 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 2, 2      |
		| 140483187886696:11:5:4:140483078710984 |       421958164597352 |        58 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 3, 3      |
		| 140483187886696:11:4:3:140483078711328 |       421958164597352 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		4 rows in set (0.00 sec)
		
		
		update t set d=100 where c>=2 and  c<=3;
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140483187886696:1068:140483078714024   |                 51465 |        58 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 140483187886696:11:5:3:140483078710984 |                 51465 |        58 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
		| 140483187886696:11:5:4:140483078710984 |                 51465 |        58 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
		| 140483187886696:11:4:3:140483078711328 |                 51465 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
		| 140483187886696:11:4:4:140483078711328 |                 51465 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		5 rows in set (0.00 sec)

		
		update t set d=100 where c>=2 and  c<3;
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140483187886696:1068:140483078714024   |                 51467 |        58 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 140483187886696:11:5:3:140483078710984 |                 51467 |        58 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
		| 140483187886696:11:4:3:140483078711328 |                 51467 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		3 rows in set (0.00 sec)

		
	
	
	4.2 for update和lock in share mode 语句 跟 update、delete语句在范围更新中，加的行锁规则是不一样的
	
		-- for update和lock in share mode 语句，在执行相同的SQL语句，加的行锁规则是一样的。
	
		
		普通索引：
			
			范围等值查询： 
			
				普通索引的范围等值查询(lock in share mode、for update模式)加锁：
					需要访问到不满足条件的第一个二级索引记录, 并且需要加锁, 不需要对对应的主键索引记录加锁, 语句结束不会把不满足条件的二级索引记录锁释放掉。
					-- 2.4 等值范围查询--先根据主键索引更新数据再等值范围查询加锁
					-- 没毛病。
					
				update语句普通索引等值范围更新加锁：
					需要访问到不满足条件的第一个二级索引记录+对应的主键索引记录为止, 并且需要加锁, 语句结束会把不满足条件的锁释放掉(二级索引记录锁+对应的主键索引记录锁)。
					-- 3.6 等值范围更新--先根据主键索引更新数据再等值范围更新加锁
					-- 3.6.2 等值范围更新--先等值范围更新加锁再根据主键索引更新数据
					-- 3.6.3 等值范围更新--先等值范围更新加锁再根据二级索引更新数据
								
				-- 访问到的记录都会加锁。
				-- 同时要考虑多个索引的情况。
				
				delete语句普通索引等值范围更新加锁:
					需要访问到不满足条件的第一个二级索引记录+对应的主键索引记录为止, 并且需要加锁, 语句结束会把不满足条件的锁释放掉(二级索引记录锁+对应的主键索引记录锁)。
					-- 3.3 等值范围删除--先根据主键索引删除数据再等值范围删除加锁

				
			范围查询： 
			
				普通索引的范围查询(lock in share mode、for update模式)加锁：
					需要访问到不满足条件的第一个二级索引记录, 并且需要加锁, 不需要对对应的主键索引记录加锁, 语句结束不会把不满足条件的二级索引记录锁释放掉。
					-- 2.5 范围查询--先根据二级索引删除数据再范围查询加锁
					-- 2.9 范围查询--先根据主键索引更新数据再范围查询加锁
					

					
				update语句普通索引范围更新加锁：
					需要访问到不满足条件的第一个二级索引记录+对应的主键索引记录为止, 并且需要加锁, 语句结束会把不满足条件的锁释放掉(二级索引记录锁+对应的主键索引记录锁)。
					-- 3.10 范围更新--先根据主键索引更新数据再范围更新加锁
					-- 3.11 范围更新--先范围更新加锁再根据主键索引更新数据

				
				delete语句普通索引范围更新加锁：
					需要访问到不满足条件的第一个二级索引记录+对应的主键索引记录为止, 并且需要加锁, 语句结束会把不满足条件的锁释放掉(二级索引记录锁+对应的主键索引记录锁)。
					
					-- 3.12 范围更新--先根据普通索引删除数据再根据二级索引更新数据		
					-- 3.13 范围更新--根据二级索引更新数据再根据普通索引删除数据
	
			--尾点延伸。

	4.3 范围加锁：
		lock in share mode模式和for update模式，对不满足条件的二级索引记录加锁，不需要回到主键索引记录上加锁， 语句结束不会把不满足条件的二级索引记录锁释放掉。
		update和delete语句，对不满足条件的二级索引记录加锁，需要回到主键索引记录上加锁, 语句结束会把不满足条件的锁释放掉(二级索引记录锁+对应的主键索引记录锁)。
			

	

做实验，不断推翻之前得到的结论，不断验证之前得到的结论。


		
		