
1. 表结构和数据的初始

2. 测试1


1. 表结构和数据的初始
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
	
	
	root@mysqldb 18:18:  [sbtest]> select * from t1;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  3 |    3 |    3 |
	|  5 |    5 |    5 |
	+----+------+------+
	3 rows in set (0.00 sec)


	root@mysqldb 18:18:  [sbtest]> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.00 sec)

2. 测试1
	session A      session B
	begin;      
	select * from t1 where id>=1 and id<=3 for update; 
	
	T1
				   begin;
				   insert into t1 values(2,2,2);
				   (Query OK)
				   
	select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	
	T1
		root@mysqldb 06:06:  [sbtest]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140412282083920:1163:140412211753048  |                  4366 |        68 | t1          | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 140412282083920:3:4:2:140412211750008 |                  4366 |        68 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
		| 140412282083920:3:4:3:140412211750008 |                  4366 |        68 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		3 rows in set (0.00 sec)
		
	T2
		root@mysqldb 06:06:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140412282084784:1163:140412211759000  |                  4367 |        69 | t1          | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 140412282083920:1163:140412211753048  |                  4366 |        68 | t1          | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 140412282083920:3:4:2:140412211750008 |                  4366 |        68 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
		| 140412282083920:3:4:3:140412211750008 |                  4366 |        68 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		4 rows in set (0.00 sec)
	
	没有间隙锁啊。

	
3. 测试2
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
								(Blocke)
									
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139645745561008:1060:139645627205528  |                  2094 |        64 | t1          | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139645745561008:3:4:2:139645627202600 |                  2094 |        64 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
	| 139645745561008:3:4:3:139645627202944 |                  2094 |        64 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 3         |
	| 139645745560144:1060:139645627199576  |                  2093 |        63 | t1          | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139645745560144:3:4:3:139645627196536 |                  2093 |        63 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	5 rows in set (0.00 sec)



	
	
