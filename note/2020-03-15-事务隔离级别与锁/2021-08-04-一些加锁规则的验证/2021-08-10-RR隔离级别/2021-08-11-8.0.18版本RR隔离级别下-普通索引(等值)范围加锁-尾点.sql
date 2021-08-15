
1. 环境、表结构和数据的初始化

2.0 用 lock in share mode语句做验证
	
	2.1 等值范围查询--先根据二级索引删除数据再等值范围查询加锁
	2.2 等值范围查询--先根据二级索引等值范围查询加锁再删除数据
		2.2.2 等值范围查询--先根据二级索引等值范围查询加锁再根据主键索引更新数据
	2.3 等值范围查询--先根据二级索引更新数据再等值范围查询加锁
	2.4 等值范围查询--先根据主键索引更新数据再等值范围查询加锁

	2.5 范围查询--先根据二级索引删除数据再范围查询加锁
	2.6 范围查询--先范围查询加锁再根据二级索引删除数据
	2.7 范围查询--先范围查询加锁再根据主键索引删除数据
	2.8 范围查询--先范围查询加锁再根据二级索引更新数据
	2.9 范围查询--先范围查询加锁再根据主键索引更新数据
	2.10 范围查询--先根据主键索引更新数据再范围查询加锁
	2.11 范围查询--先根据主键索引更新数据再范围查询加锁
	2.12 范围查询--先根据主键索引更新数据再范围查询加锁
	
3.0 用update和delete语句做验证
	3.1 等值范围更新--先根据二级索引删除数据再等值范围更新加锁
	3.2 等值范围删除--先根据二级索引删除数据再等值范围删除加锁
		3.2.2 等值范围删除--先根据二级索引删除数据再等值更新加锁
	3.3 等值范围删除--先根据主键索引删除数据再等值范围删除加锁
	3.4 等值范围更新--先根据主键索引删除数据再等值范围更新加锁
	3.5 等值范围更新--先对主键索引的记录加锁再等值范围更新加锁
	3.6 等值范围更新--先根据主键索引更新数据再等值范围更新加锁
		3.6.2 等值范围更新--先等值范围更新加锁再根据主键索引更新数据
	3.7 等值范围更新--先等值范围更新加锁再根据二级索引更新数据

	
	3.12 范围更新--先根据普通索引删除数据再根据二级索引更新数据

	3.13 范围更新--根据二级索引更新数据再根据普通索引删除数据


4. 小结	

	4.1 各自的加锁规则 
	4.2 for update和lock in share mode 语句 跟 update、delete语句在范围更新中，加的行锁规则是不一样的。
	4.3 范围加锁总结
	
	
1. 环境、表结构和数据的初始化


	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%isolation%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	+-----------------------+-----------------+
	1 row in set (0.20 sec)

	mysql> select @@transaction_isolation;
	+-------------------------+
	| @@transaction_isolation |
	+-------------------------+
	| REPEATABLE-READ         |
	+-------------------------+
	1 row in set (0.07 sec)



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





2.0 用 lock in share mode语句做验证


2.1 等值范围查询--先根据二级索引删除数据再等值范围查询加锁
	
	session A           session B	
	begin;
	delete from t where c=4;
	
						begin;
						select * from t where c>=2 and  c<=3 lock in share mode;
						(Blocked)	


	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139990965156456:1068:139990969414312   |                 48850 |        90 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965156456:11:5:5:139990969411272 |                 48850 |        90 | t           | c          | RECORD    | X             | GRANTED     | 4, 4      |
	| 139990965156456:11:4:5:139990969411616 |                 48850 |        90 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	| 139990965156456:11:5:6:139990969411960 |                 48850 |        90 | t           | c          | RECORD    | X,GAP         | GRANTED     | 5, 5      |
	| 139990965157328:1068:139990969420264   |       421465941867984 |        91 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139990965157328:11:5:3:139990969417336 |       421465941867984 |        91 | t           | c          | RECORD    | S             | GRANTED     | 2, 2      |
	| 139990965157328:11:5:4:139990969417336 |       421465941867984 |        91 | t           | c          | RECORD    | S             | GRANTED     | 3, 3      |
	| 139990965157328:11:4:3:139990969417680 |       421465941867984 |        91 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 139990965157328:11:4:4:139990969417680 |       421465941867984 |        91 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 139990965157328:11:5:5:139990969418024 |       421465941867984 |        91 | t           | c          | RECORD    | S             | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	10 rows in set (0.00 sec)
	
	
	
2.2 等值范围查询--先根据二级索引等值范围查询加锁再删除数据

	session A		session B	
	begin;
	select * from t where c>=2 and  c<=3 lock in share mode;
	
	T1 
					begin;
					delete from t where c=4;
					(Blocked)	
					
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139990965157328:1068:139990969420264   |                 48853 |        91 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965157328:11:5:5:139990969417336 |                 48853 |        91 | t           | c          | RECORD    | X             | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	| 139990965156456:1068:139990969414312   |       421465941867112 |        90 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139990965156456:11:5:3:139990969411272 |       421465941867112 |        90 | t           | c          | RECORD    | S             | GRANTED     | 2, 2      |
	| 139990965156456:11:5:4:139990969411272 |       421465941867112 |        90 | t           | c          | RECORD    | S             | GRANTED     | 3, 3      |
	| 139990965156456:11:5:5:139990969411272 |       421465941867112 |        90 | t           | c          | RECORD    | S             | GRANTED     | 4, 4      |
	| 139990965156456:11:4:3:139990969411616 |       421465941867112 |        90 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 139990965156456:11:4:4:139990969411616 |       421465941867112 |        90 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	8 rows in set (0.00 sec)


	-- 普通索引的范围等值查询, 需要访问到不满足条件的第一个值为止, 并且需要加锁, 不会把不满足条件的锁释放掉.

	
2.2.2 等值范围查询--先根据二级索引等值范围查询加锁再根据主键索引更新数据

	session A		session B	
	begin;
	select * from t where c>=2 and  c<=3 lock in share mode;
					begin;
					update t set d=100 where id=4;
					(Query OK )
					
					(Blocked)	
2.3 等值范围查询--先根据二级索引更新数据再等值范围查询加锁
	session A           session B	
	begin;
	update t set d=100 where c=4;

						begin;
						select * from t where c>=2 and  c<=3 lock in share mode;
						(Blocked)

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140244931869288:1068:140244842246824   |                 50957 |        60 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140244931869288:11:5:5:140244842243784 |                 50957 |        60 | t           | c          | RECORD    | X             | GRANTED     | 4, 4      |
	| 140244931869288:11:4:5:140244842244128 |                 50957 |        60 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	| 140244931869288:11:5:6:140244842244472 |                 50957 |        60 | t           | c          | RECORD    | X,GAP         | GRANTED     | 5, 5      |
	| 140244931870160:1068:140244842252776   |       421719908580816 |        61 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140244931870160:11:5:3:140244842249848 |       421719908580816 |        61 | t           | c          | RECORD    | S             | GRANTED     | 2, 2      |
	| 140244931870160:11:5:4:140244842249848 |       421719908580816 |        61 | t           | c          | RECORD    | S             | GRANTED     | 3, 3      |
	| 140244931870160:11:4:3:140244842250192 |       421719908580816 |        61 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 140244931870160:11:4:4:140244842250192 |       421719908580816 |        61 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140244931870160:11:5:5:140244842250536 |       421719908580816 |        61 | t           | c          | RECORD    | S             | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	10 rows in set (0.00 sec)


2.4 等值范围查询--先根据主键索引更新数据再等值范围查询加锁
	
	session A           session B	
	begin;
	update t set d=100 where id=4;

						begin;
						select * from t where c>=2 and  c<=3 lock in share mode;
						(Query Ok)
						
------------------------------------------------------------------------------------------------------------------------------------------------------------------

			
2.5 范围查询--先根据二级索引删除数据再范围查询加锁

	session A           session B	
	begin;
	delete from t where c=3;
	
						begin;
						select * from t where c>=2 and  c<3 lock in share mode;						
						(Blocked)	

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139990965156456:1068:139990969414312   |                 48865 |        97 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965156456:11:5:4:139990969411272 |                 48865 |        97 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 139990965156456:11:4:4:139990969411616 |                 48865 |        97 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139990965156456:11:5:5:139990969411960 |                 48865 |        97 | t           | c          | RECORD    | X,GAP         | GRANTED     | 4, 4      |
	| 139990965157328:1068:139990969420264   |       421465941867984 |        96 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139990965157328:11:5:3:139990969417336 |       421465941867984 |        96 | t           | c          | RECORD    | S             | GRANTED     | 2, 2      |
	| 139990965157328:11:4:3:139990969417680 |       421465941867984 |        96 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 139990965157328:11:5:4:139990969418024 |       421465941867984 |        96 | t           | c          | RECORD    | S             | WAITING     | 3, 3      |
	-- 被二级索引 c=3 的记录锁阻塞。
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	8 rows in set (0.00 sec)


2.6 范围查询--先范围查询加锁再根据二级索引删除数据

	session A           session B	
	begin;
	select * from t where c>=2 and  c<3 lock in share mode;	
			
						begin;
						delete from t where c=3;
						(Blocked)	
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139990965157328:1068:139990969420264   |                 48872 |        96 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965157328:11:5:4:139990969417336 |                 48872 |        96 | t           | c          | RECORD    | X             | WAITING     | 3, 3      |
	-- 被二级索引 c=3 的记录锁阻塞。
	| 139990965156456:1068:139990969414312   |       421465941867112 |        97 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139990965156456:11:5:3:139990969411272 |       421465941867112 |        97 | t           | c          | RECORD    | S             | GRANTED     | 2, 2      |
	| 139990965156456:11:5:4:139990969411272 |       421465941867112 |        97 | t           | c          | RECORD    | S             | GRANTED     | 3, 3      |
	| 139990965156456:11:4:3:139990969411616 |       421465941867112 |        97 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	6 rows in set (0.00 sec)
	
	

2.7 范围查询--先范围查询加锁再根据主键索引删除数据

	session A           session B	
	begin;
	select * from t where c>=2 and  c<3 lock in share mode;	
			
						begin;
						delete from t where id=3;
						(Blocked)	
						
							
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139990965157328:1068:139990969420264   |                 48873 |        96 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965157328:11:4:4:139990969417336 |                 48873 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139990965157328:11:5:4:139990969417680 |                 48873 |        96 | t           | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 3, 3      |
	-- 被二级索引 c=3 的记录锁阻塞。
	| 139990965156456:1068:139990969414312   |       421465941867112 |        97 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139990965156456:11:5:3:139990969411272 |       421465941867112 |        97 | t           | c          | RECORD    | S             | GRANTED     | 2, 2      |
	| 139990965156456:11:5:4:139990969411272 |       421465941867112 |        97 | t           | c          | RECORD    | S             | GRANTED     | 3, 3      |
	| 139990965156456:11:4:3:139990969411616 |       421465941867112 |        97 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.00 sec)


2.8 范围查询--先范围查询加锁再根据二级索引更新数据

	session A           session B	
	begin;
	select * from t where c>=2 and  c<3 lock in share mode;	
			
						begin;
						update t set d=100 where c=3;
						(Blocked)
	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140244931870160:1068:140244842252776   |                 50953 |        61 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140244931870160:11:5:4:140244842249848 |                 50953 |        61 | t           | c          | RECORD    | X             | WAITING     | 3, 3      |
	-- 被二级索引 c=3 的记录锁阻塞。
	| 140244931869288:1068:140244842246824   |       421719908579944 |        60 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140244931869288:11:5:3:140244842243784 |       421719908579944 |        60 | t           | c          | RECORD    | S             | GRANTED     | 2, 2      |
	| 140244931869288:11:5:4:140244842243784 |       421719908579944 |        60 | t           | c          | RECORD    | S             | GRANTED     | 3, 3      |
	| 140244931869288:11:4:3:140244842244128 |       421719908579944 |        60 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	6 rows in set (0.00 sec)


2.9 范围查询--先范围查询加锁再根据主键索引更新数据

	session A           session B	
	begin;
	select * from t where c>=2 and  c<3 lock in share mode;	
			
						begin;
						update t set d=100 where id=3;
						(Query Ok)



2.10 范围查询--先根据主键索引更新数据再范围查询加锁

	session A           session B	
	begin;
	update t set d=100 where id=3;
	
						begin;
						select * from t where c>=2 and  c<3 lock in share mode;	
						(Query Ok)	


2.11 范围查询--先根据主键索引更新数据再范围查询加锁
	session A           session B	
	begin;
	update t set d=100 where id=3;
	
						begin;
						select * from t where c>=2 and  c<3 for update;	
						(Query Ok)	
						
	
2.12 范围查询--先根据主键索引更新数据再范围查询加锁
	
	session A           session B	
	begin;
	update t set d=100 where c=3;
	
						begin;
						select * from t where c>=2 and  c<3 lock in share mode;		


	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140244931869288:1068:140244842246824   |                 50954 |        60 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140244931869288:11:5:4:140244842243784 |                 50954 |        60 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 140244931869288:11:4:4:140244842244128 |                 50954 |        60 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 140244931869288:11:5:5:140244842244472 |                 50954 |        60 | t           | c          | RECORD    | X,GAP         | GRANTED     | 4, 4      |
	| 140244931870160:1068:140244842252776   |       421719908580816 |        61 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140244931870160:11:5:3:140244842249848 |       421719908580816 |        61 | t           | c          | RECORD    | S             | GRANTED     | 2, 2      |
	| 140244931870160:11:4:3:140244842250192 |       421719908580816 |        61 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 140244931870160:11:5:4:140244842250536 |       421719908580816 |        61 | t           | c          | RECORD    | S             | WAITING     | 3, 3      |
	-- 被二级索引 c=3 的记录锁阻塞。
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	8 rows in set (0.01 sec)


3.0 用update和delete语句做验证
	
	update t set d=100 where c>=2 and  c<=3;		
		
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139990965156456:1068:139990969414312   |                 48882 |        97 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965156456:11:5:3:139990969411272 |                 48882 |        97 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 139990965156456:11:5:4:139990969411272 |                 48882 |        97 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 139990965156456:11:5:5:139990969411272 |                 48882 |        97 | t           | c          | RECORD    | X             | GRANTED     | 4, 4      |
	| 139990965156456:11:4:3:139990969411616 |                 48882 |        97 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139990965156456:11:4:4:139990969411616 |                 48882 |        97 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139990965156456:11:4:5:139990969411616 |                 48882 |        97 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.00 sec)



	delete from t where c>=2 and  c<=3;
			
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139990965156456:1068:139990969414312   |                 48884 |        97 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965156456:11:5:3:139990969411272 |                 48884 |        97 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 139990965156456:11:5:4:139990969411272 |                 48884 |        97 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 139990965156456:11:5:5:139990969411272 |                 48884 |        97 | t           | c          | RECORD    | X             | GRANTED     | 4, 4      |
	| 139990965156456:11:4:3:139990969411616 |                 48884 |        97 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139990965156456:11:4:4:139990969411616 |                 48884 |        97 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139990965156456:11:4:5:139990969411616 |                 48884 |        97 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.00 sec)




3.1 等值范围更新--先根据二级索引删除数据再等值范围更新加锁
	
	session A           session B
	begin;
	delete from t where c=4;
						
						begin;
						update t set d=100 where c>=2 and  c<=3;
						(Blocked)
	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139990965157328:1068:139990969420264   |                 48891 |        96 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965157328:11:5:3:139990969417336 |                 48891 |        96 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 139990965157328:11:5:4:139990969417336 |                 48891 |        96 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 139990965157328:11:4:3:139990969417680 |                 48891 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139990965157328:11:4:4:139990969417680 |                 48891 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139990965157328:11:5:5:139990969418024 |                 48891 |        96 | t           | c          | RECORD    | X             | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	| 139990965156456:1068:139990969414312   |                 48890 |        97 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965156456:11:5:5:139990969411272 |                 48890 |        97 | t           | c          | RECORD    | X             | GRANTED     | 4, 4      |
	| 139990965156456:11:4:5:139990969411616 |                 48890 |        97 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	| 139990965156456:11:5:6:139990969411960 |                 48890 |        97 | t           | c          | RECORD    | X,GAP         | GRANTED     | 5, 5      |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	10 rows in set (0.00 sec)

	
3.2 等值范围删除--先根据二级索引删除数据再等值范围删除加锁

	session A           session B
	begin;
	delete from t where c=4;
						
						begin;
						delete from t where c>=2 and  c<=3;
						(Blocked)
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139990965157328:1068:139990969420264   |                 48893 |        96 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965157328:11:5:3:139990969417336 |                 48893 |        96 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 139990965157328:11:5:4:139990969417336 |                 48893 |        96 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 139990965157328:11:4:3:139990969417680 |                 48893 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139990965157328:11:4:4:139990969417680 |                 48893 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139990965157328:11:5:5:139990969418024 |                 48893 |        96 | t           | c          | RECORD    | X             | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	| 139990965156456:1068:139990969414312   |                 48890 |        97 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965156456:11:5:5:139990969411272 |                 48890 |        97 | t           | c          | RECORD    | X             | GRANTED     | 4, 4      |
	| 139990965156456:11:4:5:139990969411616 |                 48890 |        97 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	| 139990965156456:11:5:6:139990969411960 |                 48890 |        97 | t           | c          | RECORD    | X,GAP         | GRANTED     | 5, 5      |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	10 rows in set (0.00 sec)


3.2.2 等值范围删除--先根据二级索引删除数据再等值更新加锁
	session A           session B
	begin;
	delete from t where c>=2 and  c<=3;
	
						begin;
						update t set d=100 where c=4;	
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140160119758288:1068:140160016648680   |                 52541 |        73 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140160119758288:11:5:5:140160016645752 |                 52541 |        73 | t           | c          | RECORD    | X             | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	| 140160119757416:1068:140160016642728   |                 52536 |        72 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140160119757416:11:5:3:140160016639688 |                 52536 |        72 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 140160119757416:11:5:4:140160016639688 |                 52536 |        72 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 140160119757416:11:5:5:140160016639688 |                 52536 |        72 | t           | c          | RECORD    | X             | GRANTED     | 4, 4      |
	| 140160119757416:11:4:3:140160016640032 |                 52536 |        72 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 140160119757416:11:4:4:140160016640032 |                 52536 |        72 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 140160119757416:11:4:5:140160016640032 |                 52536 |        72 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)


3.3 等值范围删除--先根据主键索引删除数据再等值范围删除加锁

	
	session A           session B
	begin;
	delete from t where id=4;
						
						begin;
						delete from t where c>=2 and  c<=3;
						(Blocked)
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139990965157328:1068:139990969420264   |                 48901 |        96 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965157328:11:5:3:139990969417336 |                 48901 |        96 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 139990965157328:11:5:4:139990969417336 |                 48901 |        96 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 139990965157328:11:4:3:139990969417680 |                 48901 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139990965157328:11:4:4:139990969417680 |                 48901 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139990965157328:11:5:5:139990969418024 |                 48901 |        96 | t           | c          | RECORD    | X             | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	| 139990965156456:1068:139990969414312   |                 48900 |        97 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965156456:11:4:5:139990969411272 |                 48900 |        97 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	| 139990965156456:11:5:5:139990969411616 |                 48900 |        96 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)



3.4 等值范围更新--先根据主键索引删除数据再等值范围更新加锁
	
	session A           session B
	begin;
	delete from t where id=4;
						
						begin;
						update t set c=100 where c>=2 and  c<=3;
						(Blocked)

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139990965157328:1068:139990969420264   |                 48907 |        96 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965157328:11:5:3:139990969417336 |                 48907 |        96 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 139990965157328:11:5:4:139990969417336 |                 48907 |        96 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 139990965157328:11:4:3:139990969417680 |                 48907 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139990965157328:11:4:4:139990969417680 |                 48907 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139990965157328:11:5:5:139990969418024 |                 48907 |        96 | t           | c          | RECORD    | X             | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	| 139990965156456:1068:139990969414312   |                 48900 |        97 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965156456:11:4:5:139990969411272 |                 48900 |        97 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	| 139990965156456:11:5:5:139990969411616 |                 48900 |        96 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 4, 4      |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)



3.5 等值范围更新--先对主键索引的记录加锁再等值范围更新加锁

	session A           session B
	begin;
	SELECT * FROM t WHERE id=4 FOR UPDATE;
	
						begin;
						update t set d=100 where c>=2 and  c<=3;
						(Blocked)
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139990965157328:1068:139990969420264   |                 48910 |        96 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965157328:11:5:3:139990969417336 |                 48910 |        96 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 139990965157328:11:5:4:139990969417336 |                 48910 |        96 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 139990965157328:11:5:5:139990969417336 |                 48910 |        96 | t           | c          | RECORD    | X             | GRANTED     | 4, 4      |
	| 139990965157328:11:4:3:139990969417680 |                 48910 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139990965157328:11:4:4:139990969417680 |                 48910 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139990965157328:11:4:5:139990969418024 |                 48910 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 4         |
	-- 被主键索引 id=4 的记录锁阻塞。
	| 139990965156456:1068:139990969414312   |                 48909 |        97 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965156456:11:4:5:139990969411272 |                 48909 |        97 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)

3.6 等值范围更新--先根据主键索引更新数据再等值范围更新加锁

	session A           session B
	begin;
	update t set d=10 where id=4;
	--这里没有更新二级索引的记录
						begin;
						update t set d=100 where c>=2 and  c<=3;
						(Blocked)


	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139990965157328:1068:139990969420264   |                 48913 |        96 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965157328:11:5:3:139990969417336 |                 48913 |        96 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 139990965157328:11:5:4:139990969417336 |                 48913 |        96 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 139990965157328:11:5:5:139990969417336 |                 48913 |        96 | t           | c          | RECORD    | X             | GRANTED     | 4, 4      |
	| 139990965157328:11:4:3:139990969417680 |                 48913 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139990965157328:11:4:4:139990969417680 |                 48913 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139990965157328:11:4:5:139990969418024 |                 48913 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 4         |
	-- 被主键索引 id=4 的记录锁阻塞。
	| 139990965156456:1068:139990969414312   |                 48912 |        97 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965156456:11:4:5:139990969411272 |                 48912 |        97 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)
		
3.6.2 等值范围更新--先等值范围更新加锁再根据主键索引更新数据
	
	session A           session B
	begin;
	update t set d=100 where c>=2 and  c<=3;
	
	--这里没有更新二级索引的记录
						begin;
						update t set d=10 where id=4;
						(Blocked)

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139668065922512:1068:139667974457832   |                 52006 |        60 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139668065922512:11:4:5:139667974454904 |                 52006 |        60 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 4         |
	| 139668065921640:1068:139667974451880   |                 52005 |        58 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139668065921640:11:5:3:139667974448840 |                 52005 |        58 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 139668065921640:11:5:4:139667974448840 |                 52005 |        58 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 139668065921640:11:5:5:139667974448840 |                 52005 |        58 | t           | c          | RECORD    | X             | GRANTED     | 4, 4      |
	| 139668065921640:11:4:3:139667974449184 |                 52005 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139668065921640:11:4:4:139667974449184 |                 52005 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139668065921640:11:4:5:139667974449184 |                 52005 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)

						
						
3.7 等值范围更新--先等值范围更新加锁再根据二级索引更新数据

	session A           session B
	begin;
	update t set d=100 where c>=2 and  c<=3;
						begin;
						update t set d=10 where c=4;
						(Blocked)

	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140244931870160:1068:140244842252776   |                 50961 |        65 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140244931870160:11:5:5:140244842249848 |                 50961 |        65 | t           | c          | RECORD    | X             | WAITING     | 4, 4      |
	-- 被二级索引 c=4 的记录锁阻塞。
	| 140244931869288:1068:140244842246824   |                 50960 |        64 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140244931869288:11:5:3:140244842243784 |                 50960 |        64 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 140244931869288:11:5:4:140244842243784 |                 50960 |        64 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 140244931869288:11:5:5:140244842243784 |                 50960 |        64 | t           | c          | RECORD    | X             | GRANTED     | 4, 4      |
	| 140244931869288:11:4:3:140244842244128 |                 50960 |        64 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 140244931869288:11:4:4:140244842244128 |                 50960 |        64 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 140244931869288:11:4:5:140244842244128 |                 50960 |        64 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.01 sec)
		

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

		
		
3.8 范围更新--先根据二级索引删除数据再范围更新加锁
	
	session A       session B
	begin;
	delete from t where c=3;


					begin;
					update t set d=100 where c>=2 and  c<3;
					(Blocked)
					
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139990965157328:1068:139990969420264   |                 48917 |        96 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965157328:11:5:3:139990969417336 |                 48917 |        96 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 139990965157328:11:4:3:139990969417680 |                 48917 |        96 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139990965157328:11:5:4:139990969418024 |                 48917 |        96 | t           | c          | RECORD    | X             | WAITING     | 3, 3      |
	-- 被普通索引 c=3 的记录锁阻塞。
	| 139990965156456:1068:139990969414312   |                 48916 |        97 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139990965156456:11:5:4:139990969411272 |                 48916 |        97 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 139990965156456:11:4:4:139990969411616 |                 48916 |        97 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 139990965156456:11:5:5:139990969411960 |                 48916 |        97 | t           | c          | RECORD    | X,GAP         | GRANTED     | 4, 4      |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	8 rows in set (0.00 sec)

		
3.9 范围更新--先根据主键索引删除数据再范围更新加锁
	
	session A       session B
	begin;
	delete from t where id=3;


					begin;
					update t set d=100 where c>=2 and  c<3;
					(Blocked)

	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140047680695760:1068:140047609301480   |                 49930 |        59 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140047680695760:11:5:3:140047609298552 |                 49930 |        59 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 140047680695760:11:4:3:140047609298896 |                 49930 |        59 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 140047680695760:11:5:4:140047609299240 |                 49930 |        59 | t           | c          | RECORD    | X             | WAITING     | 3, 3      |
	-- 被普通索引 c=3 的记录锁阻塞。
	| 140047680694888:1068:140047609295528   |                 49929 |        58 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140047680694888:11:4:4:140047609292488 |                 49929 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 140047680694888:11:5:4:140047609292832 |                 49929 |        59 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 3      |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.02 sec)


3.10 范围更新--先范围更新加锁再根据普通索引删除加锁
	
	session A       session B
	begin;
	update t set d=100 where c>=2 and  c<3;

					begin;
					delete from t where c=3;
					(Blocked)

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139668065922512:1068:139667974457832   |                 52033 |        78 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139668065921640:1068:139667974451880   |                 52032 |        79 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139668065921640:11:5:3:139667974448840 |                 52032 |        79 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 139668065921640:11:5:4:139667974448840 |                 52032 |        79 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 139668065921640:11:4:3:139667974449184 |                 52032 |        79 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139668065921640:11:4:4:139667974449184 |                 52032 |        79 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	6 rows in set (0.00 sec)


3.11 范围更新--先根据主键索引更新数据再范围更新加锁


	session A       session B
	begin;
	update t set d=100 where id=3;

					begin;
					update t set d=100 where c>=2 and  c<3;
					(Blocked)	
					
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140244931870160:1068:140244842252776   |                 50966 |        65 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140244931870160:11:5:3:140244842249848 |                 50966 |        65 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 140244931870160:11:5:4:140244842249848 |                 50966 |        65 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 140244931870160:11:4:3:140244842250192 |                 50966 |        65 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 140244931870160:11:4:4:140244842250536 |                 50966 |        65 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 3         |
	-- 被主键索引 id=3 的记录锁阻塞。
	| 140244931869288:1068:140244842246824   |                 50965 |        67 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140244931869288:11:4:4:140244842243784 |                 50965 |        67 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.00 sec)

	
3.12 范围更新--先根据普通索引删除数据再根据二级索引更新数据
	
	session A       session B
	begin;
	delete from t where c>=2 and  c<3;
	
					begin;
					update t set d=100 where c=3;	
					(Blocked)

					
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140160119758288:1068:140160016648680   |                 52556 |        73 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140160119758288:11:5:4:140160016645752 |                 52556 |        73 | t           | c          | RECORD    | X             | WAITING     | 3, 3      |
	-- 被二级索引 c=3 的记录锁阻塞。
	| 140160119757416:1068:140160016642728   |                 52555 |        72 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140160119757416:11:5:3:140160016639688 |                 52555 |        72 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 140160119757416:11:5:4:140160016639688 |                 52555 |        72 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 140160119757416:11:4:3:140160016640032 |                 52555 |        72 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 140160119757416:11:4:4:140160016640032 |                 52555 |        72 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.00 sec)



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
	| 140160119758288:1068:140160016648680   |                 52560 |        73 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140160119758288:11:5:3:140160016645752 |                 52560 |        73 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
	| 140160119758288:11:4:3:140160016646096 |                 52560 |        73 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 140160119758288:11:5:4:140160016646440 |                 52560 |        73 | t           | c          | RECORD    | X             | WAITING     | 3, 3      |
	-- 被二级索引 c=3 的记录锁阻塞。
	| 140160119757416:1068:140160016642728   |                 52559 |        72 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140160119757416:11:5:4:140160016639688 |                 52559 |        72 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
	| 140160119757416:11:4:4:140160016640032 |                 52559 |        72 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	| 140160119757416:11:5:5:140160016640376 |                 52559 |        72 | t           | c          | RECORD    | X,GAP         | GRANTED     | 4, 4      |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	8 rows in set (0.00 sec)


---------------------------------------------------------------------------------------------------------------------------------------------------------------------
		




4. 小结	

	4.1 各自的加锁规则 
		-- 仅供参考
		
		select * from t where c>=2 and  c<=3 lock in share mode;	
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140244931869288:1068:140244842246824   |       421719908579944 |        72 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 140244931869288:11:5:3:140244842243784 |       421719908579944 |        72 | t           | c          | RECORD    | S             | GRANTED     | 2, 2      |
		| 140244931869288:11:5:4:140244842243784 |       421719908579944 |        72 | t           | c          | RECORD    | S             | GRANTED     | 3, 3      |
		| 140244931869288:11:5:5:140244842243784 |       421719908579944 |        72 | t           | c          | RECORD    | S             | GRANTED     | 4, 4      |
		| 140244931869288:11:4:3:140244842244128 |       421719908579944 |        72 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
		| 140244931869288:11:4:4:140244842244128 |       421719908579944 |        72 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		6 rows in set (0.00 sec)
		
		
		select * from t where c>=2 and  c<3 lock in share mode;			
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140244931869288:1068:140244842246824   |       421719908579944 |        72 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 140244931869288:11:5:3:140244842243784 |       421719908579944 |        72 | t           | c          | RECORD    | S             | GRANTED     | 2, 2      |
		| 140244931869288:11:5:4:140244842243784 |       421719908579944 |        72 | t           | c          | RECORD    | S             | GRANTED     | 3, 3      |
		| 140244931869288:11:4:3:140244842244128 |       421719908579944 |        72 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		4 rows in set (0.00 sec)



		update t set d=100 where c>=2 and  c<=3;		
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140244931869288:1068:140244842246824   |                 50969 |        69 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 140244931869288:11:5:3:140244842243784 |                 50969 |        69 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
		| 140244931869288:11:5:4:140244842243784 |                 50969 |        69 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
		| 140244931869288:11:4:3:140244842244128 |                 50969 |        69 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
		| 140244931869288:11:4:4:140244842244128 |                 50969 |        69 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		5 rows in set (0.00 sec)

		
		update t set d=100 where c>=2 and  c<3;			
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140244931869288:1068:140244842246824   |                 50963 |        67 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 140244931869288:11:5:3:140244842243784 |                 50963 |        67 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
		| 140244931869288:11:5:4:140244842243784 |                 50963 |        67 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
		| 140244931869288:11:4:3:140244842244128 |                 50963 |        67 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
		| 140244931869288:11:4:4:140244842244128 |                 50963 |        67 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		5 rows in set (0.00 sec)
	
	
	4.2 for update和lock in share mode 语句 跟 update、delete语句在范围更新中，加的行锁规则是不一样的。
		
		普通索引：
			
			范围等值查询： 
				
				普通索引的范围等值查询(lock in share mode、for update模式)加锁：
				
					需要访问到不满足条件的第一个二级索引记录, 并且需要加锁, 不需要对对应的主键索引记录加锁, 语句结束不会把不满足条件的二级索引记录锁释放掉。
					-- 没毛病。
					同时参考对应的笔记：《2021-08-12-RR隔离级别下-普通索引(等值)范围加锁分析.sql》
					
					-- 2.2 等值范围查询--先根据二级索引等值范围查询加锁再删除数据
					-- 2.2.2 等值范围查询--先根据二级索引等值范围查询加锁再根据主键索引更新数据
					-- 2.3 等值范围查询--先根据二级索引更新数据再等值范围查询加锁
					-- 2.4 等值范围查询--先根据主键索引更新数据再等值范围查询加锁
		
					2.2.2 等值范围查询--先根据二级索引等值范围查询加锁再根据主键索引更新数据

						session A		session B	
						begin;
						select * from t where c>=2 and  c<=3 lock in share mode;
										
										begin;
										update t set d=100 where id=4;
										(Query OK )
						
						begin;
						select * from t where c>=2 and  c<=3 for update;
										begin;
										update t set d=100 where id=4;
										(Query OK )
										
					2.4 等值范围查询--先根据主键索引更新数据再等值范围查询加锁
					
						session A           session B	
						begin;
						update t set d=100 where id=4;

											begin;
											select * from t where c>=2 and  c<=3 lock in share mode;
											(Query Ok)	
											
				update语句普通索引等值范围更新加锁:
					
					需要访问到不满足条件的第一个二级索引记录+对应的主键索引记录为止, 并且需要加锁, 语句结束不会把不满足条件的锁释放掉。
					-- 没毛病。
					同时参考对应的笔记：《2021-08-12-RR隔离级别下-普通索引(等值)范围加锁分析.sql》
					
					-- 3.6.2 等值范围更新--先等值范围更新加锁再根据主键索引更新数据
					session A           session B
					begin;
					update t set d=100 where c>=2 and  c<=3;
					
					--这里没有更新二级索引的记录
										begin;
										update t set d=10 where id=4;
										(Blocked)

					mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
					+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
					| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
					+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
					| 139668065922512:1068:139667974457832   |                 52006 |        60 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
					| 139668065922512:11:4:5:139667974454904 |                 52006 |        60 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 4         |
					| 139668065921640:1068:139667974451880   |                 52005 |        58 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
					| 139668065921640:11:5:3:139667974448840 |                 52005 |        58 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
					| 139668065921640:11:5:4:139667974448840 |                 52005 |        58 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
					| 139668065921640:11:5:5:139667974448840 |                 52005 |        58 | t           | c          | RECORD    | X             | GRANTED     | 4, 4      |
					| 139668065921640:11:4:3:139667974449184 |                 52005 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
					| 139668065921640:11:4:4:139667974449184 |                 52005 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
					| 139668065921640:11:4:5:139667974449184 |                 52005 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
					+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
					9 rows in set (0.00 sec)		
				

				delete语句普通索引等值范围更新加锁:
					需要访问到不满足条件的第一个二级索引记录+对应的主键索引记录为止, 并且需要加锁, 语句结束不会把不满足条件的锁释放掉。
					-- 没毛病。
					-- 3.2.2 等值范围删除--先根据二级索引删除数据再等值更新加锁
					-- 3.3 等值范围删除--先根据主键索引删除数据再等值范围删除加锁
					
					
			----------------------------------------------------------------------------------------------------------------------------------------------
			
			
			范围查询：
				
				普通索引的范围查询(lock in share mode、for update模式)加锁：
					需要访问到不满足条件的第一个二级索引记录, 并且需要加锁, 不需要对对应的主键索引记录加锁, 语句结束不会把不满足条件的二级索引记录锁释放掉。
					-- 2.5 范围查询--先范围查询加锁再根据二级索引删除数据
					-- 2.7 范围查询--先范围查询加锁再根据二级索引更新数据

					2.5 范围查询--先范围查询加锁再根据二级索引删除数据

						session A           session B	
						begin;
						select * from t where c>=2 and  c<3 lock in share mode;	
								
											begin;
											delete from t where c=3;
											(Blocked)	
						

					2.7 范围查询--先范围查询加锁再根据二级索引更新数据

						session A           session B	
						begin;
						select * from t where c>=2 and  c<3 lock in share mode;	
								
											begin;
											update t set d=100 where c=3;
											(Blocked)
										
				update语句普通索引范围更新加锁：
				
					需要访问到不满足条件的第一个二级索引记录+对应的主键索引记录为止, 并且需要加锁, 语句结束不会把不满足条件的锁释放掉。	
					
					3.9 范围更新--先范围更新加锁再根据普通索引删除加锁
						
						session A       session B
						begin;
						update t set d=100 where c>=2 and  c<3;

										begin;
										delete from t where c=3;
										(Blocked)

						mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
						+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
						| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
						+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
						| 139668065922512:1068:139667974457832   |                 52033 |        78 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
						| 139668065921640:1068:139667974451880   |                 52032 |        79 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
						| 139668065921640:11:5:3:139667974448840 |                 52032 |        79 | t           | c          | RECORD    | X             | GRANTED     | 2, 2      |
						| 139668065921640:11:5:4:139667974448840 |                 52032 |        79 | t           | c          | RECORD    | X             | GRANTED     | 3, 3      |
						| 139668065921640:11:4:3:139667974449184 |                 52032 |        79 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
						| 139668065921640:11:4:4:139667974449184 |                 52032 |        79 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
						+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
						6 rows in set (0.00 sec)
													
				delete语句普通索引范围更新加锁:
					需要访问到不满足条件的第一个二级索引记录+对应的主键索引记录为止, 并且需要加锁, 语句结束不会把不满足条件的锁释放掉。	

					-- 3.12 范围更新--先根据普通索引删除数据再根据二级索引更新数据
					-- 3.13 范围更新--根据二级索引更新数据再根据普通索引删除数据
					
	4.3 范围加锁总结
		lock in share mode模式和for update模式，对不满足条件的二级索引记录加锁，不需要回到主键索引记录上加锁。
		update和delete语句，对不满足条件的二级索引记录加锁，需要回到主键索引记录上加锁，不会释放不满足条件的锁。
			
			