
1. 表结构和数据初始化和环境
4.1.4 非唯一索引范围非等值查询(不等号条件里的等值查询)--order by desc
4.1.4 非唯一索引范围非等值查询(不等号条件里的等值查询)--没有order by desc


3. 小结
		
1. 表结构和数据初始化和环境

	drop table t;
	CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB;
	insert into t values(0,0,0),(5,5,5),(10,10,10),(15,15,15),(20,20,20),(25,25,25);
	
	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  0 |    0 |    0 |
	|  5 |    5 |    5 |
	| 10 |   10 |   10 |
	| 15 |   15 |   15 |
	| 20 |   20 |   20 |
	| 25 |   25 |   25 |
	+----+------+------+
	6 rows in set (0.00 sec)
	
	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)

	mysql> select @@global.transaction_isolation;
	+--------------------------------+
	| @@global.transaction_isolation |
	+--------------------------------+
	| REPEATABLE-READ                |
	+--------------------------------+
	1 row in set (0.00 sec)

	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.00 sec)

		
4.1.4 非唯一索引范围非等值查询(不等号条件里的等值查询)--order by desc
	起点降级, 尾点延伸

	session A                            session B
	mysql> select * from t where c>9 and c<12 order by c desc for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 10 |   10 |   10 |
	+----+------+------+
	1 row in set (0.00 sec)
									begin;
									delete from t where c=15;
									(Query OK)
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139811159239272:1352:139811050549928    |               1004631 |       135 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139811159239272:295:5:5:139811050546888 |               1004631 |       135 | t           | c          | RECORD    | X,GAP         | GRANTED     | 15, 15    |
	| 139811159239272:295:5:3:139811050547232 |               1004631 |       135 | t           | c          | RECORD    | X             | GRANTED     | 5, 5      |
	| 139811159239272:295:5:4:139811050547232 |               1004631 |       135 | t           | c          | RECORD    | X             | GRANTED     | 10, 10    |
	
	| 139811159239272:295:4:4:139811050547576 |               1004631 |       135 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 10        |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	5 rows in set (0.00 sec)
	
	这里跟 "唯一索引范围非等值查询(不等号条件里的等值查询)--order by desc" select * from t where id>9 and id<12 order by id desc for update; 加锁规则一致.
	
	加锁范围: c: gap lock: (10,15) + c: next-key lock: (5,10] + c: next-key lock: (0,5] + primary: record lock: [10]
	
	如果是主键, 加锁范围: primary: gap lock: (10,15) + primary: next-key lock: (5,10] + primary: next-key lock: (0,5]
	
4.1.4 非唯一索引范围非等值查询(不等号条件里的等值查询)--没有order by desc
	起点不降级, 尾点正常
	
	session A					session A		
	begin;
	select * from t where c>9 and c<12 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 10 |   10 |   10 |
	+----+------+------+
	1 row in set (0.00 sec)
	T1
								begin;
								insert into t values(9,9,9);
								(Blocked)
	T2							
								insert into t values(11,11,11);
								(Blocked)
	T3							
								insert into t values(13,13,13);
								(Blocked)
	T4
								delete from t where id=5;
								(Query OK)
								
	
								delete from t where id=15;
								(Blocked)
	T5
								
	T1
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139811159239272:1352:139811050549928    |               1004632 |       137 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |

		| 139811159239272:295:5:4:139811050546888 |               1004632 |       137 | t           | c          | RECORD    | X             | GRANTED     | 10, 10    |
		| 139811159239272:295:5:5:139811050546888 |               1004632 |       137 | t           | c          | RECORD    | X             | GRANTED     | 15, 15    |

		| 139811159239272:295:4:4:139811050547232 |               1004632 |       137 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 10        |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		4 rows in set (0.00 sec)
		
		加锁范围: c: next-key lock: (5,10] + c: nex lock: (10, 15] + primary: record lock: [10]
		如果是主键, 加锁范围: primary: next-key lock: (5,10] + primary: gap lock: (10,15)
		

	T2
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| 139811159240144:1352:139811050555880    |               1004644 |       139 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
		| 139811159240144:295:5:4:139811050552952 |               1004644 |       139 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 10, 10    |
		| 139811159239272:1352:139811050549928    |               1004641 |       137 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
		| 139811159239272:295:5:4:139811050546888 |               1004641 |       137 | t           | c          | RECORD    | X                      | GRANTED     | 10, 10    |
		| 139811159239272:295:5:5:139811050546888 |               1004641 |       137 | t           | c          | RECORD    | X                      | GRANTED     | 15, 15    |
		| 139811159239272:295:4:4:139811050547232 |               1004641 |       137 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP          | GRANTED     | 10        |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		6 rows in set (0.00 sec)

	T3
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| 139811159240144:1352:139811050555880    |               1004645 |       139 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
		| 139811159240144:295:5:5:139811050552952 |               1004645 |       139 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 15, 15    |
		| 139811159239272:1352:139811050549928    |               1004641 |       137 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
		| 139811159239272:295:5:4:139811050546888 |               1004641 |       137 | t           | c          | RECORD    | X                      | GRANTED     | 10, 10    |
		| 139811159239272:295:5:5:139811050546888 |               1004641 |       137 | t           | c          | RECORD    | X                      | GRANTED     | 15, 15    |
		| 139811159239272:295:4:4:139811050547232 |               1004641 |       137 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP          | GRANTED     | 10        |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		6 rows in set (0.00 sec)

	T4
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| 139811159240144:1352:139811050555880    |               1004646 |       139 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
		| 139811159240144:295:5:5:139811050552952 |               1004646 |       139 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 15, 15    |
		| 139811159239272:1352:139811050549928    |               1004641 |       137 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
		| 139811159239272:295:5:4:139811050546888 |               1004641 |       137 | t           | c          | RECORD    | X                      | GRANTED     | 10, 10    |
		| 139811159239272:295:5:5:139811050546888 |               1004641 |       137 | t           | c          | RECORD    | X                      | GRANTED     | 15, 15    |
		| 139811159239272:295:4:4:139811050547232 |               1004641 |       137 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP          | GRANTED     | 10        |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		6 rows in set (0.00 sec)


	T5

		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139811159240144:1352:139811050555880    |               1004633 |       139 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139811159240144:295:5:5:139811050552952 |               1004633 |       139 | t           | c          | RECORD    | X             | WAITING     | 15, 15    |
		| 139811159239272:1352:139811050549928    |               1004632 |       137 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139811159239272:295:5:4:139811050546888 |               1004632 |       137 | t           | c          | RECORD    | X             | GRANTED     | 10, 10    |
		| 139811159239272:295:5:5:139811050546888 |               1004632 |       137 | t           | c          | RECORD    | X             | GRANTED     | 15, 15    |
		| 139811159239272:295:4:4:139811050547232 |               1004632 |       137 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 10        |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		6 rows in set (0.00 sec)

