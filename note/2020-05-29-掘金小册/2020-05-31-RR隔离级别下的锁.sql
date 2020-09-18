
1. 表结构和数据的初始化
2. 全表扫描

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

		这个案例在RC隔离级别下就可以插入。

	