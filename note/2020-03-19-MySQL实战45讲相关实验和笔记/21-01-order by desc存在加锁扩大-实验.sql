
1. 表结构和数据初始化和环境

4.1.4 唯一索引范围非等值查询(不等号条件里的等值查询)--order by desc
		起点降级, 尾点延伸
4.1.4 唯一索引范围非等值查询(不等号条件里的等值查询)--没有order by desc
		起点降级, 尾点正常


4.2.6 非唯一索引范围等值查询--order by desc --这个例子不好理解
		起点降级, 尾点延伸
4.2.6 非唯一索引范围等值查询--没有order by desc
		起点降级, 尾点延伸，跟 8.0.18 之前的 唯一索引范围 bug 一样。
	
声明: 
	1. 起点降级是指使用到了优化1和优化2
	2. 尾点延伸是指使用了唯一索引的bug
	
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


4.1.4 唯一索引范围非等值查询(不等号条件里的等值查询)--order by desc
	起点降级, 尾点延伸
		
	session A
	begin;
	select * from t where id>9 and id<12 order by id desc for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 10 |   10 |   10 |
	+----+------+------+
	1 row in set (0.00 sec)
	
	在执行过程中，通过树搜索的方式定位记录的时候，用的是 等值查询 的方法。
	
	mysql>  select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	| 139859108161544:1303:139859033411576    |                869547 |      1997 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL      |
	| 139859108161544:246:4:5:139859033408536 |                869547 |      1997 | t           | PRIMARY    | RECORD    | X,GAP     | GRANTED     | 15        |
	| 139859108161544:246:4:3:139859033408880 |                869547 |      1997 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 5         |
	| 139859108161544:246:4:4:139859033408880 |                869547 |      1997 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 10        |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	4 rows in set (0.00 sec)

	LOCK_MODE = 'X,GAP' 表示行锁锁定的范围为gap锁, 并且是一个排他锁.
	
	参考笔记 <21: RR行锁 | 为什么我只改一行的语句，锁这么多？--有章可循>
	
	加锁范围: primary: gap lock: (10,15) + primary: next-key lock: (5,10] + primary: next-key lock: (0,5]
	如果是普通索引c, 加锁范围: c: gap lock: (10,15) + c: next-key lock: (5,10] + c: next-key lock: (0,5]
	
4.1.4 唯一索引范围非等值查询(不等号条件里的等值查询)--没有order by desc
	起点降级, 尾点正常
	
	session A					session A		
	begin;
	select * from t where id>9 and id<12 for update;
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
								(Query OK)
								
	T1 							
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		| 139811159242760:1351:139811050573816    |               1004590 |       123 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL      |
		| 139811159242760:294:4:4:139811050570776 |               1004590 |       123 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 10        |
		| 139811159242760:294:4:5:139811050571120 |               1004590 |       123 | t           | PRIMARY    | RECORD    | X,GAP     | GRANTED     | 15        |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		3 rows in set (0.00 sec)
		
		加锁范围: primary: next-key lock: (5,10] + primary: gap lock: (10,15)
		如果是普通索引c, 加锁范围: c: next-key lock: (5,10] + c: next-key lock: (10, 15] + primary: record lock: [10]
		
		
	T2
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| 139811159243632:1351:139811050579960    |               1004592 |       124 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
		| 139811159243632:294:4:4:139811050577016 |               1004592 |       124 | t           | PRIMARY    | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 10        |
		
		| 139811159242760:1351:139811050573816    |               1004590 |       123 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
		| 139811159242760:294:4:4:139811050570776 |               1004590 |       123 | t           | PRIMARY    | RECORD    | X                      | GRANTED     | 10        |
		| 139811159242760:294:4:5:139811050571120 |               1004590 |       123 | t           | PRIMARY    | RECORD    | X,GAP                  | GRANTED     | 15        |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		5 rows in set (0.00 sec)

	T3
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| 139811159243632:1351:139811050579960    |               1004593 |       124 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
		| 139811159243632:294:4:5:139811050577016 |               1004593 |       124 | t           | PRIMARY    | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 15        |
		| 139811159242760:1351:139811050573816    |               1004590 |       123 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
		| 139811159242760:294:4:4:139811050570776 |               1004590 |       123 | t           | PRIMARY    | RECORD    | X                      | GRANTED     | 10        |
		| 139811159242760:294:4:5:139811050571120 |               1004590 |       123 | t           | PRIMARY    | RECORD    | X,GAP                  | GRANTED     | 15        |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		5 rows in set (0.00 sec)
	
	T4
		root@mysqldb 11:23:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| 139811159243632:1351:139811050579960    |               1004594 |       124 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
		| 139811159243632:294:4:5:139811050577016 |               1004594 |       124 | t           | PRIMARY    | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 15        |
		| 139811159242760:1351:139811050573816    |               1004590 |       123 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
		| 139811159242760:294:4:4:139811050570776 |               1004590 |       123 | t           | PRIMARY    | RECORD    | X                      | GRANTED     | 10        |
		| 139811159242760:294:4:5:139811050571120 |               1004590 |       123 | t           | PRIMARY    | RECORD    | X,GAP                  | GRANTED     | 15        |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		5 rows in set (0.00 sec)

4.2.6 非唯一索引范围等值查询--order by desc --这个例子不好理解
	起点降级, 尾点延伸
	mysql> select c,id from t order by c asc;
	+------+----+
	| c    | id |
	+------+----+
	|    0 |  0 |
	|    5 |  5 |
	|   10 | 10 |
	|   15 | 15 |
	|   20 | 20 |
	|   25 | 25 |
	+------+----+
	6 rows in set (0.00 sec)
	 

	session A									session B									
	begin;
	select * from t where c>=15 and c<=20 order by c desc lock in share mode; 
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 20 |   20 |   20 |
	| 15 |   15 |   15 |
	+----+------+------+
	2 rows in set (0.00 sec)
												begin;
												insert into t values(6,6,6);
												(Blocked)
	T1
												update t set d=d+1 where c=25;		
												(Query OK)
											
	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;

	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| 139859108160672:1303:139859033405624    |                869665 |      2056 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |

	| 139859108160672:246:5:4:139859033402584 |                869665 |      2056 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 10, 10    |

	| 139859108158928:1303:139859033393640    |       421334084869584 |      2054 | t           | NULL       | TABLE     | IS                     | GRANTED     | NULL      |
	| 139859108158928:246:5:7:139859033390712 |       421334084869584 |      2054 | t           | c          | RECORD    | S,GAP                  | GRANTED     | 25, 25    |

	| 139859108158928:246:5:4:139859033391056 |       421334084869584 |      2054 | t           | c          | RECORD    | S                      | GRANTED     | 10, 10    |

	| 139859108158928:246:5:5:139859033391056 |       421334084869584 |      2054 | t           | c          | RECORD    | S                      | GRANTED     | 15, 15    |
	| 139859108158928:246:5:6:139859033391056 |       421334084869584 |      2054 | t           | c          | RECORD    | S                      | GRANTED     | 20, 20    |
	| 139859108158928:246:4:5:139859033391400 |       421334084869584 |      2054 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP          | GRANTED     | 15        |
	| 139859108158928:246:4:6:139859033391400 |       421334084869584 |      2054 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP          | GRANTED     | 20        |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	9 rows in set (0.00 sec)

	root@mysqldb 18:23:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| locked_index | locked_type | waiting_query               | waiting_lock_mode      | blocking_lock_mode |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| c            | RECORD      | insert into t values(6,6,6) | X,GAP,INSERT_INTENTION | S                  |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	1 row in set (0.00 sec)


4.2.6 非唯一索引范围等值查询--没有order by desc
	起点降级, 尾点延伸，跟 8.0.18 之前的 唯一索引范围 bug 一样。

	mysql> select c,id from t order by c asc;
	+------+----+
	| c    | id |
	+------+----+
	|    0 |  0 |
	|    5 |  5 |
	|   10 | 10 |
	|   15 | 15 |
	|   20 | 20 |
	|   25 | 25 |
	+------+----+
	6 rows in set (0.00 sec)
 

	session A							session B			     session C						
	begin;
	mysql> select * from t where c>=15 and c<=20 lock in share mode;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 15 |   15 |   15 |
	| 20 |   20 |   20 |
	+----+------+------+
	2 rows in set (0.00 sec)
	T0
										insert into t values1(11,11,11);
										(Blocked)

	T1
																 update t set d=d+1 where c=25;
																 (Blocked)
	T2

	T0
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139811159239272:1352:139811050549928    |       421286135949928 |       132 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 139811159239272:295:5:5:139811050546888 |       421286135949928 |       132 | t           | c          | RECORD    | S             | GRANTED     | 15, 15    |
		| 139811159239272:295:5:6:139811050546888 |       421286135949928 |       132 | t           | c          | RECORD    | S             | GRANTED     | 20, 20    |
		| 139811159239272:295:5:7:139811050546888 |       421286135949928 |       132 | t           | c          | RECORD    | S             | GRANTED     | 25, 25    |
		| 139811159239272:295:4:5:139811050547232 |       421286135949928 |       132 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 15        |
		| 139811159239272:295:4:6:139811050547232 |       421286135949928 |       132 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 20        |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		6 rows in set (0.00 sec)
	
	T1
		root@mysqldb 21:44:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| 139859108159800:1303:139859033399624    |                869671 |      2059 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
		| 139859108159800:246:5:5:139859033396744 |                869671 |      2059 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 15, 15    |
		| 139859108158928:1303:139859033393640    |       421334084869584 |      2058 | t           | NULL       | TABLE     | IS                     | GRANTED     | NULL      |
		| 139859108158928:246:5:5:139859033390712 |       421334084869584 |      2058 | t           | c          | RECORD    | S                      | GRANTED     | 15, 15    |
		| 139859108158928:246:5:6:139859033390712 |       421334084869584 |      2058 | t           | c          | RECORD    | S                      | GRANTED     | 20, 20    |
		| 139859108158928:246:5:7:139859033390712 |       421334084869584 |      2058 | t           | c          | RECORD    | S                      | GRANTED     | 25, 25    |
		| 139859108158928:246:4:5:139859033391056 |       421334084869584 |      2058 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP          | GRANTED     | 15        |
		| 139859108158928:246:4:6:139859033391056 |       421334084869584 |      2058 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP          | GRANTED     | 20        |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		8 rows in set (0.00 sec)

		root@mysqldb 21:44:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+--------------------------------+------------------------+--------------------+
		| locked_index | locked_type | waiting_query                  | waiting_lock_mode      | blocking_lock_mode |
		+--------------+-------------+--------------------------------+------------------------+--------------------+
		| c            | RECORD      | insert into t values(11,11,11) | X,GAP,INSERT_INTENTION | S                  |
		+--------------+-------------+--------------------------------+------------------------+--------------------+
		1 row in set (0.00 sec)


	T2
		root@mysqldb 21:44:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139859108159800:1303:139859033399624    |                869672 |      2059 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |

		| 139859108159800:246:5:7:139859033396744 |                869672 |      2059 | t           | c          | RECORD    | X             | WAITING     | 25, 25    |

		| 139859108158928:1303:139859033393640    |       421334084869584 |      2058 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 139859108158928:246:5:5:139859033390712 |       421334084869584 |      2058 | t           | c          | RECORD    | S             | GRANTED     | 15, 15    |
		| 139859108158928:246:5:6:139859033390712 |       421334084869584 |      2058 | t           | c          | RECORD    | S             | GRANTED     | 20, 20    |

		| 139859108158928:246:5:7:139859033390712 |       421334084869584 |      2058 | t           | c          | RECORD    | S             | GRANTED     | 25, 25    |

		| 139859108158928:246:4:5:139859033391056 |       421334084869584 |      2058 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 15        |
		| 139859108158928:246:4:6:139859033391056 |       421334084869584 |      2058 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 20        |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		8 rows in set (0.00 sec)

		root@mysqldb 21:49:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+-------------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query                 | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+-------------------------------+-------------------+--------------------+
		| c            | RECORD      | update t set d=d+1 where c=25 | X                 | S                  |
		+--------------+-------------+-------------------------------+-------------------+--------------------+
		1 row in set (0.00 sec)


	这里session C为什么会被锁住：
		c<=20 加锁范围是 c:next-key lock: (15, 20] + (20, 25]
		至于为什么会锁住 c=25这一行记录，是因为 c<=20 是范围查询，范围查询就需要往后找，直到找到不满足条件的第一个值为止，所以找到 c=25 这一行，但是这里又不是全等值查询，所以用不到优化2.
		--理解了。
		
3. 小结
		