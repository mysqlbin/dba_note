

1. 表结构和数据的初始化
2. RR隔离级别
	2.0 分别用lock in share mode模式和update语句做验证
	2.1 等值范围查询--先根据二级索引更新数据再等值范围查询加锁
	2.2 范围查询--先根据二级索引更新数据再等值范围查询加锁
	2.3 等值范围更新--先根据二级索引更新数据再等值范围更新加锁
	2.4 范围更新--先根据二级索引更新数据再范围更新加锁
	
3. 小结		


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
	
	
2. RR隔离级别

	mysql> show global variables like '%iso%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	+-----------------------+-----------------+
	1 row in set (0.01 sec)

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)


2.0 分别用lock in share mode模式和update语句做验证
	
	lock in share mode模式：
		范围等值查询
			begin;
			select * from t where c>=2 and  c<=3 lock in share mode;
			+----+------+------+
			| id | c    | d    |
			+----+------+------+
			|  2 |    2 |    2 |
			|  3 |    3 |    3 |
			+----+------+------+
			2 rows in set (0.00 sec)
			
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			| 139835056597608:1063:139834941305512  |       421310033308264 |       137 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
			| 139835056597608:6:5:3:139834941302472 |       421310033308264 |       137 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 2, 2      |
			| 139835056597608:6:5:4:139834941302472 |       421310033308264 |       137 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 3, 3      |
			| 139835056597608:6:5:5:139834941302472 |       421310033308264 |       137 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 4, 4      |
			| 139835056597608:6:4:3:139834941302816 |       421310033308264 |       137 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
			| 139835056597608:6:4:4:139834941302816 |       421310033308264 |       137 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			6 rows in set (0.00 sec)

		范围查询
			begin;
			select * from t where c>2 and  c<=3 lock in share mode;
			+----+------+------+
			| id | c    | d    |
			+----+------+------+
			|  3 |    3 |    3 |
			+----+------+------+
			1 row in set (0.00 sec)
			
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			| 139835056597608:1063:139834941305512  |       421310033308264 |       137 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
			| 139835056597608:6:5:4:139834941302472 |       421310033308264 |       137 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 3, 3      |
			| 139835056597608:6:5:5:139834941302472 |       421310033308264 |       137 | t           | c          | RECORD    | S,REC_NOT_GAP | GRANTED     | 4, 4      |
			| 139835056597608:6:4:4:139834941302816 |       421310033308264 |       137 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			4 rows in set (0.00 sec)

	
	update语句：
		
		等值范围更新
			begin;
			update t set d=100 where c>=2 and  c<=3;
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			| 139835056597608:1063:139834941305512  |                  3856 |       140 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
			| 139835056597608:6:5:3:139834941302472 |                  3856 |       140 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 2, 2      |
			| 139835056597608:6:5:4:139834941302472 |                  3856 |       140 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
			| 139835056597608:6:4:3:139834941302816 |                  3856 |       140 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
			| 139835056597608:6:4:4:139834941302816 |                  3856 |       140 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			5 rows in set (0.00 sec)
			
		范围更新	
			begin;
			update t set d=100 where c>2 and  c<=3;	
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			| 139835056597608:1063:139834941305512  |                  3858 |       140 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
			| 139835056597608:6:5:4:139834941302472 |                  3858 |       140 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
			| 139835056597608:6:4:4:139834941302816 |                  3858 |       140 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			3 rows in set (0.00 sec)


		
2.1 等值范围查询--先根据二级索引更新数据再等值范围查询加锁
	--起点没有延伸
	
	session A           session B	
	begin;
	update t set d=100 where c=1;
	
						begin;
						select * from t where c>=2 and  c<=3 lock in share mode;
						(Query OK)
						



2.2 范围查询--先根据二级索引更新数据再范围查询加锁

	--起点没有延伸
	session A           session B	
	begin;
	update t set d=100 where c=1;
	
						begin;
						select * from t where c>2 and  c<=3 lock in share mode;
						(Query OK)
						
	--------------------------------------------------------------------------
	
	session A           session B	
	begin;
	update t set d=100 where c=2;
	
						begin;
						select * from t where c>2 and  c<=3 lock in share mode;
						(Query OK)
						
	

2.3 等值范围更新--先根据二级索引更新数据再等值范围更新加锁

	session A           session B	
	begin;
	update t set d=100 where c=1;
	
						begin;
						update t set d=100 where c>=2 and  c<=3;
						(Query OK)
						
						
2.4 范围更新--先根据二级索引更新数据再范围更新加锁
		
	session A           session B	
	begin;
	update t set d=100 where c=1;
	
						begin;
						update t set d=100 where c>2 and  c<=3;
						(Query OK)		
	
	--------------------------------------------------------------------------
	
	begin;
	update t set d=100 where c=2;
	
						begin;
						update t set d=100 where c>2 and  c<=3;
						(Query OK)

						
3. 小结	
	
	普通索引(等值)范围加锁：没有起点延伸。
		
		
		
			
			
		