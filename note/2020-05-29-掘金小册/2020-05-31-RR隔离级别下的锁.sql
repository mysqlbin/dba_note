
1. 表结构和数据的初始化
2. 全表扫描--加了全表记录的next-key lock会导致无法再插入新的记录
3. 普通索引范围等值和非等值的加锁对比
	3.1 环境
	3.2 实验目的
	3.3 c>=15 and c<=20
	3.4 c>=15 and c<20       
	3.4 小结
	
	
4. 其它相关参考


1. 表结构和数据的初始化
	drop table if exists hero;
	CREATE TABLE hero (
		number INT,
		name VARCHAR(100),
		country varchar(100),
		PRIMARY KEY (number),
		KEY idx_name (name)
	) Engine=InnoDB CHARSET=utf8mb4;

	INSERT INTO hero VALUES (1, 'l刘备', '蜀');
	INSERT INTO hero VALUES (3, 'z诸葛亮', '蜀');
	INSERT INTO hero VALUES (8, 'c曹操', '魏');
	INSERT INTO hero VALUES (15, 'x荀彧', '魏');
	INSERT INTO hero VALUES (20, 's孙权', '吴');
	
	mysql> select * from hero;
	+--------+------------+---------+
	| number | name       | country |
	+--------+------------+---------+
	|      1 | l刘备      | 蜀      |
	|      3 | z诸葛亮    | 蜀      |
	|      8 | c曹操      | 魏      |
	|     15 | x荀彧      | 魏      |
	|     20 | s孙权      | 吴      |
	+--------+------------+---------+
	5 rows in set (0.05 sec)
	
	mysql> select * from hero order by name asc;
	+--------+------------+---------+
	| number | name       | country |
	+--------+------------+---------+
	|      8 | c曹操      | 魏      |
	|      1 | l刘备      | 蜀      |
	|     20 | s孙权      | 吴      |
	|     15 | x荀彧      | 魏      |
	|      3 | z诸葛亮    | 蜀      |
	+--------+------------+---------+
	5 rows in set (0.00 sec)
	
	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.00 sec)

	root@mysqldb 02:34:  [(none)]> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.17    |
	+-----------+
	1 row in set (0.00 sec)
	
	

2. 全表扫描
	
	mysql> select * from hero order by name asc;
	+--------+------------+---------+
	| number | name       | country |
	+--------+------------+---------+
	|      8 | c曹操      | 魏      |
	|      1 | l刘备      | 蜀      |
	|     20 | s孙权      | 吴      |
	|     15 | x荀彧      | 魏      |
	|      3 | z诸葛亮    | 蜀      |
	+--------+------------+---------+
	5 rows in set (0.00 sec)
	
	
	session A          session B
	begin;
	SELECT * FROM hero WHERE country  = '魏' LOCK IN SHARE MODE;
	T1
	
						begin;
						delete from hero where number=1;
	T2                  (Blocked)
	
	-------------------------------------------------------------
	
	T1
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
		| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA              |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
		| 140365316147792:1168:140365235548248  |       421840292858448 |        58 | hero        | NULL       | TABLE     | IS        | GRANTED     | NULL                   |
		| 140365316147792:8:4:1:140365235545208 |       421840292858448 |        58 | hero        | PRIMARY    | RECORD    | S         | GRANTED     | supremum pseudo-record |
		| 140365316147792:8:4:2:140365235545208 |       421840292858448 |        58 | hero        | PRIMARY    | RECORD    | S         | GRANTED     | 1                      |
		| 140365316147792:8:4:3:140365235545208 |       421840292858448 |        58 | hero        | PRIMARY    | RECORD    | S         | GRANTED     | 3                      |
		| 140365316147792:8:4:4:140365235545208 |       421840292858448 |        58 | hero        | PRIMARY    | RECORD    | S         | GRANTED     | 8                      |
		| 140365316147792:8:4:5:140365235545208 |       421840292858448 |        58 | hero        | PRIMARY    | RECORD    | S         | GRANTED     | 15                     |
		| 140365316147792:8:4:6:140365235545208 |       421840292858448 |        58 | hero        | PRIMARY    | RECORD    | S         | GRANTED     | 20                     |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
		7 rows in set (0.00 sec)
	
	T2
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+------------------------+
		| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA              |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+------------------------+
		| 140365316148656:1168:140365235554200  |                  7944 |        59 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL                   |
		
		| 140365316148656:8:4:2:140365235551272 |                  7944 |        59 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 1                      |
		
		| 140365316147792:1168:140365235548248  |       421840292858448 |        58 | hero        | NULL       | TABLE     | IS            | GRANTED     | NULL                   |
		| 140365316147792:8:4:1:140365235545208 |       421840292858448 |        58 | hero        | PRIMARY    | RECORD    | S             | GRANTED     | supremum pseudo-record |
		| 140365316147792:8:4:2:140365235545208 |       421840292858448 |        58 | hero        | PRIMARY    | RECORD    | S             | GRANTED     | 1                      |
		| 140365316147792:8:4:3:140365235545208 |       421840292858448 |        58 | hero        | PRIMARY    | RECORD    | S             | GRANTED     | 3                      |
		| 140365316147792:8:4:4:140365235545208 |       421840292858448 |        58 | hero        | PRIMARY    | RECORD    | S             | GRANTED     | 8                      |
		| 140365316147792:8:4:5:140365235545208 |       421840292858448 |        58 | hero        | PRIMARY    | RECORD    | S             | GRANTED     | 15                     |
		| 140365316147792:8:4:6:140365235545208 |       421840292858448 |        58 | hero        | PRIMARY    | RECORD    | S             | GRANTED     | 20                     |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+------------------------+
		9 rows in set (0.00 sec)
	
	-------------------------------------------------------------
	
	验证是否可以做插入动作	
		session A          session B
		begin;
		SELECT * FROM hero WHERE country  = '魏' LOCK IN SHARE MODE;
							begin;
							INSERT INTO hero VALUES (30, 'l卢建斌', '现代');
							(Blocked)
		
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
		| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE          | LOCK_STATUS | LOCK_DATA              |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
		| 140365316147792:1168:140365235548248  |                  7947 |        61 | hero        | NULL       | TABLE     | IX                 | GRANTED     | NULL                   |
		| 140365316147792:8:4:1:140365235545208 |                  7947 |        61 | hero        | PRIMARY    | RECORD    | X,INSERT_INTENTION | WAITING     | supremum pseudo-record |
		
		| 140365316148656:1168:140365235554200  |       421840292859312 |        63 | hero        | NULL       | TABLE     | IS                 | GRANTED     | NULL                   |
		| 140365316148656:8:4:1:140365235551272 |       421840292859312 |        63 | hero        | PRIMARY    | RECORD    | S                  | GRANTED     | supremum pseudo-record |
		| 140365316148656:8:4:2:140365235551272 |       421840292859312 |        63 | hero        | PRIMARY    | RECORD    | S                  | GRANTED     | 1                      |
		| 140365316148656:8:4:3:140365235551272 |       421840292859312 |        63 | hero        | PRIMARY    | RECORD    | S                  | GRANTED     | 3                      |
		| 140365316148656:8:4:4:140365235551272 |       421840292859312 |        63 | hero        | PRIMARY    | RECORD    | S                  | GRANTED     | 8                      |
		| 140365316148656:8:4:5:140365235551272 |       421840292859312 |        63 | hero        | PRIMARY    | RECORD    | S                  | GRANTED     | 15                     |
		| 140365316148656:8:4:6:140365235551272 |       421840292859312 |        63 | hero        | PRIMARY    | RECORD    | S                  | GRANTED     | 20                     |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
		9 rows in set (0.13 sec)
		
		加了全表记录的next-key lock会导致无法再插入新的记录。
		
		这个案例在RC隔离级别下就可以插入。
		
	
3.1 环境
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

3.2 实验目的
	验证 c>=15 and c<=20 和 c>=15 and c<20 的加锁区别 

3.3 c>=15 and c<=20

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
        因此, session A的加锁范围: 
				c: next-key lock: (10,15]  + c: next-key lock:(15,20] + c: next-key lock: (20, 25] +
        		prmary: record lock: [15] + prmary: record lock: [20]
		
		至于为什么会锁住 c=25这一行记录，是因为 c<=20 是范围查询，范围查询就需要往后找，直到找到不满足条件的第一个值为止，所以找到 c=25 这一行，但是这里又不是等值查询，所以用不到优化2.
		
		--理解了。

3.4  c>=15 and c<20   
    
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
        因此, session A的加锁范围: 
			c: next-key lock: (10,15]  + c: next-key lock:(15,20] + prmary: record lock: [15]

        分析正确了.
        并且验证了只有访问到的记录才会加锁,对主键记录进行加锁, 这里只访问到了主键 id=15 的这一行记录, 所以只会对这一行加锁.
	

3.4 小结

	c>=15 and c<=20的加锁范围
	
		加锁的基本单位是 next-key lock, c>=15 的加锁范围: c: next-key lock: (10,15]
        c<=20 找到 c=20, c<20 的加锁范围: c: next-key lock:(15,20]
        范围查询就需要往后找, 找到 c=25 的记录才会停止下来, 这里用不到优化规则, 所以 加锁范围是 c: next-key lock: (20, 25]
        因此, session A的加锁范围: 
				c: next-key lock: (10,15]  + c: next-key lock:(15,20] + c: next-key lock: (20, 25] +
        		prmary: record lock: [15] + prmary: record lock: [20]
		
		至于为什么会锁住 c=25这一行记录，是因为 c<=20 是范围查询，范围查询就需要往后找，直到找到不满足条件的第一个值为止，所以找到 c=25 这一行，但是这里又不是等值查询，所以用不到优化2.
		
	------------------------------------------------------------------------------------------------------------------------		
	
	c>=15 and c<20的加锁范围
        加锁的基本单位是 next-key lock, c>=15 的加锁范围: c: next-key lock: (10,15]
        范围查询就需要往后找, c<20 找到 c=20 这一行会停下来, c<20 的加锁范围: c: next-key lock:(15,20]
        因此, session A的加锁范围: 
			c: next-key lock: (10,15]  + c: next-key lock:(15,20] + 
			prmary: record lock: [15]

        分析正确了.
        并且验证了只有访问到的记录才会加锁,对主键记录进行加锁, 这里只访问到了主键 id=15 的这一行记录, 所以只会对这一行加锁.
	

4. 其它相关参考
	


	