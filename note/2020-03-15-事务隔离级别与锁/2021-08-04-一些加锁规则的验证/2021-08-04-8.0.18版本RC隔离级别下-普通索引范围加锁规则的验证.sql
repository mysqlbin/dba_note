

1. 表结构和数据的初始化
2. RC隔离级别
	2.0 用 lock in share mode语句做验证
	2.1 等值范围查询--先根据二级索引删除数据再等值范围查询加锁
	2.2 等值范围查询--先等值范围查询加锁再删除
	2.3 等值范围查询--先根据主键索引删除数据再等值范围查询加锁
	2.4 范围查询--先根据二级索引删除数据再范围查询加锁
	2.5 等值范围查询--先根据二级索引删除数据再等值范围查询加锁
		-- 起点不会延伸

3. RC隔离级别
	3.0 用update语句做验证
	3.1 等值范围更新--先根据二级索引删除数据再等值范围更新加锁
	3.2 等值范围更新--先根据主键索引删除数据再等值范围更新加锁
	
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
	

2.0 用 lock in share mode语句做验证

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


	-- 普通索引的范围等值查询, 需要访问到不满足条件的第一个值为止, 并且需要加锁, 不会把不满足条件的锁释放掉.

	
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
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)


2.2 等值范围查询--先等值范围查询加锁再删除

	session A		session B	
	begin;
	select * from t where c>=2 and  c<=3 lock in share mode;
	
	T1 
					begin;
					delete from t where c=4;


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
		| 139835056597608:1063:139834941305512  |       421310033308264 |        84 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 139835056597608:6:5:3:139834941302472 |       421310033308264 |        84 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 2, 2      |
		| 139835056597608:6:5:4:139834941302472 |       421310033308264 |        84 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 3, 3      |
		| 139835056597608:6:5:5:139834941302472 |       421310033308264 |        84 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 4, 4      |
		| 139835056597608:6:4:3:139834941302816 |       421310033308264 |        84 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
		| 139835056597608:6:4:4:139834941302816 |       421310033308264 |        84 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
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
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)

					
2.4 范围查询--先根据二级索引删除数据再范围查询加锁

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
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.00 sec)


2.5 等值范围查询--先根据二级索引删除数据再等值范围查询加锁
	
	begin;
	select * from t where c>=2 and  c<3 lock in share mode;	
	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1063:139834941305512  |       421310033308264 |        89 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139835056597608:6:5:3:139834941302472 |       421310033308264 |        89 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056597608:6:5:4:139834941302472 |       421310033308264 |        89 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056597608:6:4:3:139834941302816 |       421310033308264 |        89 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	4 rows in set (0.00 sec)
	
	-- 起点不会延伸
	
	session A           session B	
	begin;
	delete from t where c=1;
	
						begin;
						select * from t where c>=2 and  c<3 lock in share mode;				
						+----+------+------+
						| id | c    | d    |
						+----+------+------+
						|  2 |    2 |    2 |
						|  3 |    3 |    3 |
						+----+------+------+
						2 rows in set (0.00 sec)
						
				
3.0 用update语句做验证

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

3.1 等值范围更新--先根据二级索引删除数据再等值范围更新加锁
	
	session A           session B
	begin;
	delete from t where c=4;
						
						begin;
						update t set d=100 where c>=2 and  c<=3;


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
	
	| 139835056597608:1063:139834941305512  |                  3731 |        89 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:5:5:139834941302472 |                  3731 |        89 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	| 139835056597608:6:4:5:139834941302816 |                  3731 |        89 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)

	
3.2 等值范围更新--先根据主键索引删除数据再等值范围更新加锁

	
	session A           session B
	begin;
	delete from t where id=4;
						
						begin;
						update t set d=100 where c>=2 and  c<=3;
						(Blocked)
						
	root@mysqldb 15:59:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056598480:1063:139834941311464  |                  3740 |        91 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:6:5:3:139834941308536 |                  3740 |        91 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
	| 139835056598480:6:5:4:139834941308536 |                  3740 |        91 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	| 139835056598480:6:4:3:139834941308880 |                  3740 |        91 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056598480:6:4:4:139834941308880 |                  3740 |        91 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139835056598480:6:5:5:139834941309224 |                  3740 |        91 | t           | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 4, 4      |
	| 139835056597608:1063:139834941305512  |                  3735 |        89 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:4:5:139834941302472 |                  3735 |        89 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	| 139835056597608:6:5:5:139834941302816 |                  3735 |        91 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)
	
	
4. 小结	
	
	for update和lock in share mode 语句 跟 update 语句在范围更新中，加的行锁规则是不一样的。
	
	for update和lock in share mode 语句，在执行相同的SQL语句，加的行锁规则是一样的。
	
	普通索引：
		
		普通索引的范围等值查询(lock in share mode、for update模式)加锁：
			需要访问到不满足条件的第一个值为止, 并且需要加锁, 语句结束不会把不满足条件的锁释放掉.
			
		update语句普通索引范围更新加锁：
			需要访问到不满足条件的第一个值为止, 并且需要加锁, 语句结束会把不满足条件的锁释放掉.
			
		
	如果是主键索引的范围等值查询, 也是需要访问到不满足条件的第一个值为止, 并且需要加锁, 语句执行结束，如果该记录不符合查询条件，会释放掉这条记录的锁.
	
	
	
	
