

1. 环境
2. 本文目的
3. c>=15 and c<=20
4. c>=15 and c<20       

1. 环境
	root@mysqldb 09:34:  [(none)]> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)

	root@mysqldb 09:34:  [(none)]> show global variables like '%isolation%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	+-----------------------+-----------------+
	1 row in set (0.20 sec)

	root@mysqldb 09:34:  [(none)]> select @@transaction_isolation;
	+-------------------------+
	| @@transaction_isolation |
	+-------------------------+
	| REPEATABLE-READ         |
	+-------------------------+
	1 row in set (0.07 sec)

2. 本文目的
	验证 c>=15 and c<=20 和 c>=15 and c<20 的加锁区别 

3. c>=15 and c<=20
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
										insert into t values1(11,11,11);
										(Blocked)

	T1
																 update t set d=d+1 where c=25;
																 (Blocked)
	T2


	T1
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
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

		mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+--------------------------------+------------------------+--------------------+
		| locked_index | locked_type | waiting_query                  | waiting_lock_mode      | blocking_lock_mode |
		+--------------+-------------+--------------------------------+------------------------+--------------------+
		| c            | RECORD      | insert into t values(11,11,11) | X,GAP,INSERT_INTENTION | S                  |
		+--------------+-------------+--------------------------------+------------------------+--------------------+
		1 row in set (0.00 sec)


	T2
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
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

		mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+-------------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query                 | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+-------------------------------+-------------------+--------------------+
		| c            | RECORD      | update t set d=d+1 where c=25 | X                 | S                  |
		+--------------+-------------+-------------------------------+-------------------+--------------------+
		1 row in set (0.00 sec)

	session A的加锁范围:
		加锁的基本单位是 next-key lock, c>=15 的加锁范围: c: next-key lock: (10,15]
        c<=20 找到 c=20, c<20 的加锁范围: c: next-key lock:(15,20]
        范围查询就需要往后找, 找到 c=25 的记录才会停止下来, 这里用不到优化规则, 所以 加锁范围是 c: next-key lock: (20, 25]
        因此, session A的加锁范围: c: next-key lock: (10,15]  + c: next-key lock:(15,20] + c: next-key lock: (20, 25] +
        		prmary: record lock: [15] + prmary: record lock: [20]
		
		至于为什么会锁住 c=25这一行记录，是因为 c<=20 是范围查询，范围查询就需要往后找，直到找到不满足条件的第一个值为止，所以找到 c=25 这一行，但是这里又不是等值查询，所以用不到优化2.
		--理解了。

4. c>=15 and c<20       
    session A                      session B                    session C
    select * from t where c>=15 and c<20 lock in share mode;
    +----+------+------+
    | id | c    | d    |
    +----+------+------+
    | 15 |   15 |   15 |
    +----+------+------+
    1 row in set (0.00 sec)
    T1
                                   begin;
                                   delete from t where c=20; 
                                   (Blocked)
    T2                               
                                                               begin;
                                                               insert into t(11,11,11);
                                                               (Blocked)
    T3

    T1
        mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
        +-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
        | ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
        +-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
        | 139811159239272:1352:139811050549928    |       421286135949928 |       150 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
        | 139811159239272:295:5:5:139811050546888 |       421286135949928 |       150 | t           | c          | RECORD    | S             | GRANTED     | 15, 15    |
        | 139811159239272:295:5:6:139811050546888 |       421286135949928 |       150 | t           | c          | RECORD    | S             | GRANTED     | 20, 20    |
        | 139811159239272:295:4:5:139811050547232 |       421286135949928 |       150 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 15        |
        +-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
        4 rows in set (0.00 sec)
     
    T2
        mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
        +-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
        | ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
        +-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
        | 139811159240144:1352:139811050555880    |               1004659 |       152 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
        | 139811159240144:295:5:6:139811050552952 |               1004659 |       152 | t           | c          | RECORD    | X             | WAITING     | 20, 20    |
        | 139811159239272:1352:139811050549928    |       421286135949928 |       150 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
        | 139811159239272:295:5:5:139811050546888 |       421286135949928 |       150 | t           | c          | RECORD    | S             | GRANTED     | 15, 15    |
        | 139811159239272:295:5:6:139811050546888 |       421286135949928 |       150 | t           | c          | RECORD    | S             | GRANTED     | 20, 20    |
        | 139811159239272:295:4:5:139811050547232 |       421286135949928 |       150 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 15        |
        +-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
        6 rows in set (0.00 sec)

    T3
        mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
        +-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
        | ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
        +-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
        | 139811159240144:1352:139811050555880    |               1004660 |       152 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
        | 139811159240144:295:5:5:139811050552952 |               1004660 |       152 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 15, 15    |
        | 139811159239272:1352:139811050549928    |       421286135949928 |       150 | t           | NULL       | TABLE     | IS                     | GRANTED     | NULL      |
        | 139811159239272:295:5:5:139811050546888 |       421286135949928 |       150 | t           | c          | RECORD    | S                      | GRANTED     | 15, 15    |
        | 139811159239272:295:5:6:139811050546888 |       421286135949928 |       150 | t           | c          | RECORD    | S                      | GRANTED     | 20, 20    |
        | 139811159239272:295:4:5:139811050547232 |       421286135949928 |       150 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP          | GRANTED     | 15        |
        +-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
        6 rows in set (0.00 sec)

    session A的加锁范围
        加锁的基本单位是 next-key lock, c>=15 的加锁范围: c: next-key lock: (10,15]
        范围查询就需要往后找, c<20 找到 c=20 这一行会停下来, c<20 的加锁范围: c: next-key lock:(15,20]
        因此, session A的加锁范围: c: next-key lock: (10,15]  + c: next-key lock:(15,20] + prmary: record lock: [15]

        分析正确了.
        并且验证了只有访问到的记录才会加锁,对主键记录进行加锁, 这里只访问到了主键 id=15 的这一行记录, 所以只会对这一行加锁.
