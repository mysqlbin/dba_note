

1. 表结构和数据的初始化
2. RR隔离级别
	2.1 实验1--全表扫描加锁
	2.2 实验2--主键索引范围等值加锁并且有对最后一行记录加锁
	2.3 实验3--主键索引范围等值加锁
	2.4 实验4--主键索引范围等值加锁并且有对最后一行记录加锁同时后有数据插入
	2.5 实验5--主键索引范围等值加锁并且有对最后一行记录加锁同时先有数据插入
	2.6 实验6--主键索引范围等值加锁并且没有对最后一行记录加锁同时先有数据删除操作

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
	
	root@mysqldb 17:52:  [zst]> select * from t;
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

2.1 实验1--全表扫描加锁

	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.00 sec)

	mysql> select version();
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
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA              |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
	| 139811159241888:1338:139811050567864    |       421286135952544 |       167 | t           | NULL       | TABLE     | IS        | GRANTED     | NULL                   |
	| 139811159241888:281:4:1:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S         | GRANTED     | supremum pseudo-record |
	| 139811159241888:281:4:2:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 1                      |
	| 139811159241888:281:4:3:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 2                      |
	| 139811159241888:281:4:4:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 3                      |
	| 139811159241888:281:4:5:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 4                      |
	| 139811159241888:281:4:6:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 5                      |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
	7 rows in set (0.00 sec)
	
	
2.2 实验2--主键索引范围等值加锁并且有对最后一行记录加锁
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
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+------------------------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA              |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+------------------------+
	| 139811159241888:1338:139811050567864    |       421286135952544 |       167 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL                   |
	| 139811159241888:281:4:4:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3                      |
	| 139811159241888:281:4:1:139811050565168 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S             | GRANTED     | supremum pseudo-record |
	| 139811159241888:281:4:5:139811050565168 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 4                      |
	| 139811159241888:281:4:6:139811050565168 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 5                      |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+------------------------+
	5 rows in set (0.00 sec)


2.3 实验3--主键索引范围等值加锁并且没有对最后一行记录加锁同时后有数据删除操作

	session A            session B

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
	| 139811159241888:1338:139811050567864    |       421286135952544 |       167 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139811159241888:281:4:4:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 139811159241888:281:4:5:139811050565168 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 4         |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	3 rows in set (0.00 sec)


2.4 实验4--主键索引范围等值加锁并且有对最后一行记录加锁同时后有数据插入

	session A           	session B
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
							INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');
							(Blocked)
							
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE          | LOCK_STATUS | LOCK_DATA              |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
	| 139811159242760:1338:139811050573816    |               1004714 |       168 | t           | NULL       | TABLE     | IX                 | GRANTED     | NULL                   |
	| 139811159242760:281:4:1:139811050570776 |               1004714 |       168 | t           | PRIMARY    | RECORD    | X,INSERT_INTENTION | WAITING     | supremum pseudo-record |
	
	| 139811159239272:1338:139811050549928    |       421286135949928 |       170 | t           | NULL       | TABLE     | IS                 | GRANTED     | NULL                   |
	| 139811159239272:281:4:1:139811050546888 |       421286135949928 |       170 | t           | PRIMARY    | RECORD    | S                  | GRANTED     | supremum pseudo-record |
	| 139811159239272:281:4:2:139811050546888 |       421286135949928 |       170 | t           | PRIMARY    | RECORD    | S                  | GRANTED     | 1                      |
	| 139811159239272:281:4:3:139811050546888 |       421286135949928 |       170 | t           | PRIMARY    | RECORD    | S                  | GRANTED     | 2                      |
	| 139811159239272:281:4:4:139811050546888 |       421286135949928 |       170 | t           | PRIMARY    | RECORD    | S                  | GRANTED     | 3                      |
	| 139811159239272:281:4:5:139811050546888 |       421286135949928 |       170 | t           | PRIMARY    | RECORD    | S                  | GRANTED     | 4                      |
	| 139811159239272:281:4:6:139811050546888 |       421286135949928 |       170 | t           | PRIMARY    | RECORD    | S                  | GRANTED     | 5                      |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
	9 rows in set (0.01 sec)

	RC隔离级别下，session B 不会被阻塞。
	
	
2.5 实验5--主键索引范围等值加锁并且有对最后一行记录加锁同时先有数据插入
	
	session A           session B
	begin;
	INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');
							
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
						5 rows in set (0.00 sec)
	
	RC隔离级别下，session B 会被阻塞。		
		
		
2.6 实验6--主键索引范围等值加锁并且没有对最后一行记录加锁同时先有数据删除操作

	session A            session B
	begin;
	delete from t where id=5;

						begin;
						select * from t where id>=3 and  id<=4 lock in share mode;
						+----+------+------+
						| id | c    | d    |
						+----+------+------+
						|  3 |    3 |    3 |
						|  4 |    4 |    4 |
						+----+------+------+
						2 rows in set (0.00 sec)
						
	-- 不再需要访问到不满足条件的记录为止，这个是对唯一索引范围加锁bug的优化。

						
						
							begin;
							delete from t where id=5;
							Query OK, 1 row affected (0.00 sec)
						
	RC隔离级别下，session B 会被阻塞。
	
3. 小结

	细心观察，还是可以有进一步理解的：
	
		1. 8.0.18 的RR隔离级别优化了唯一索引范围加锁的bug
		2. 如果范围加锁包含索引的最大值，会锁住索引上不存在的最大值。
	
	
	