
1. 表结构和数据的初始化
2. 全表扫描--加了全表记录的next-key lock会导致无法再插入新的记录
3. 普通索引范围等值和非等值的加锁对比
	3.1 环境
	3.2 初始化表结构和数据
	3.3 实验目的
	3.4 c>=15 and c<=20
		3.4.1 用 lock in share mode 语句验证
		3.4.2 用 update 语句验证
		3.4.3 用 for update 语句验证

	3.5  c>=15 and c<20   
		3.5.1 用 lock in share mode 语句验证
		3.5.2 用 update 语句验证
		3.5.3 用 for update 语句验证
		
	3.6 小结
	
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


3.2 初始化表结构和数据

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


3.3 实验目的
	
	验证 c>=15 and c<=20 和 c>=15 and c<20 分别在lock in share mode 、update语句模式下的加锁区别 

3.4 c>=15 and c<=20

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
 
3.4.1 用 lock in share mode 语句验证

	session A							session B			     session C		               session D 				
	begin;
	mysql> select * from t where c>=15 and c<=20 lock in share mode;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 15 |   15 |   15 |
	| 20 |   20 |   20 |
	+----+------+------+
	2 rows in set (0.00 sec)
	T1
										begin;	
										insert into t values1(11,11,11);
										(Blocked)

	T2
																 begin;	
																 update t set d=d+1 where c=25;
																 (Blocked)
	T3
																							 begin;		
																						     update t set d=d+1 where id=25;
																							 (Query Ok)
	T4
	
	
	T1
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139668065921640:1069:139667974451880   |       421143042632296 |        63 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 139668065921640:12:5:5:139667974448840 |       421143042632296 |        63 | t           | c          | RECORD    | S             | GRANTED     | 15, 15    |
		| 139668065921640:12:5:6:139667974448840 |       421143042632296 |        63 | t           | c          | RECORD    | S             | GRANTED     | 20, 20    |
		| 139668065921640:12:5:7:139667974448840 |       421143042632296 |        63 | t           | c          | RECORD    | S             | GRANTED     | 25, 25    |
		| 139668065921640:12:4:5:139667974449184 |       421143042632296 |        63 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 15        |
		| 139668065921640:12:4:6:139667974449184 |       421143042632296 |        63 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 20        |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		6 rows in set (0.01 sec)
		
	
	T2
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| 139668065922512:1069:139667974457832   |                 52013 |        62 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
		| 139668065922512:12:5:5:139667974454904 |                 52013 |        62 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 15, 15    |
		| 139668065921640:1069:139667974451880   |       421143042632296 |        63 | t           | NULL       | TABLE     | IS                     | GRANTED     | NULL      |
		| 139668065921640:12:5:5:139667974448840 |       421143042632296 |        63 | t           | c          | RECORD    | S                      | GRANTED     | 15, 15    |
		| 139668065921640:12:5:6:139667974448840 |       421143042632296 |        63 | t           | c          | RECORD    | S                      | GRANTED     | 20, 20    |
		| 139668065921640:12:5:7:139667974448840 |       421143042632296 |        63 | t           | c          | RECORD    | S                      | GRANTED     | 25, 25    |
		| 139668065921640:12:4:5:139667974449184 |       421143042632296 |        63 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP          | GRANTED     | 15        |
		| 139668065921640:12:4:6:139667974449184 |       421143042632296 |        63 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP          | GRANTED     | 20        |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		8 rows in set (0.01 sec)
			
	
	T3
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139668065922512:1069:139667974457832   |                 52014 |        62 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065922512:12:5:7:139667974454904 |                 52014 |        62 | t           | c          | RECORD    | X             | WAITING     | 25, 25    |
		| 139668065921640:1069:139667974451880   |       421143042632296 |        63 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 139668065921640:12:5:5:139667974448840 |       421143042632296 |        63 | t           | c          | RECORD    | S             | GRANTED     | 15, 15    |
		| 139668065921640:12:5:6:139667974448840 |       421143042632296 |        63 | t           | c          | RECORD    | S             | GRANTED     | 20, 20    |
		| 139668065921640:12:5:7:139667974448840 |       421143042632296 |        63 | t           | c          | RECORD    | S             | GRANTED     | 25, 25    |
		| 139668065921640:12:4:5:139667974449184 |       421143042632296 |        63 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 15        |
		| 139668065921640:12:4:6:139667974449184 |       421143042632296 |        63 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 20        |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		8 rows in set (0.00 sec)
			
	

	session A的加锁范围:
		加锁的基本单位是 next-key lock, c>=15 的加锁范围: c: next-key lock: (10,15]
        c<=20 找到 c=20, c<20 的加锁范围: c: next-key lock:(15,20]
        范围查询就需要往后找, 找到 c=25 的记录才会停止下来, 这里用不到优化规则, 所以 加锁范围是 c: next-key lock: (20, 25]
        因此, session A的加锁范围: 
				c: next-key lock: (10,15]  + c: next-key lock:(15,20] + c: next-key lock: (20, 25] +
        		prmary: record lock: [15] + prmary: record lock: [20]
		
		至于为什么会锁住 c=25这一行记录，是因为 c<=20 是范围查询，范围查询就需要往后找，直到找到不满足条件的第一个值为止，所以找到 c=25 这一行，但是这里又不是等值查询，所以用不到优化2.
		
		--理解了。

3.4.2 用 update 语句验证

	CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB;
	insert into t values(0,0,0),(5,5,5),(10,10,10),(15,15,15),(20,20,20),(25,25,25);

	session A							session B			 		session C	   					
	begin;
	mysql> update t set d=100 where c>=15 and c<=20;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 15 |   15 |   15 |
	| 20 |   20 |   20 |
	+----+------+------+
	2 rows in set (0.00 sec)
										

	T1
										 update t set d=d+1 where c=25;
										 (Blocked)
	
	T2
																	begin;
																	update t set d=d+1 where id=25;
																	(Blocked)
										 
	T3
	
	
	

	T1 

		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139668065921640:1069:139667974451880   |                 52000 |        58 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065921640:12:5:5:139667974448840 |                 52000 |        58 | t           | c          | RECORD    | X             | GRANTED     | 15, 15    |
		| 139668065921640:12:5:6:139667974448840 |                 52000 |        58 | t           | c          | RECORD    | X             | GRANTED     | 20, 20    |
		| 139668065921640:12:5:7:139667974448840 |                 52000 |        58 | t           | c          | RECORD    | X             | GRANTED     | 25, 25    |
		| 139668065921640:12:4:5:139667974449184 |                 52000 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 15        |
		| 139668065921640:12:4:6:139667974449184 |                 52000 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 20        |
		| 139668065921640:12:4:7:139667974449184 |                 52000 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 25        |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		7 rows in set (0.00 sec)

	T2
		
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139668065922512:1069:139667974457832   |                 52001 |        60 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065922512:12:5:7:139667974454904 |                 52001 |        60 | t           | c          | RECORD    | X             | WAITING     | 25, 25    |
		| 139668065921640:1069:139667974451880   |                 52000 |        58 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065921640:12:5:5:139667974448840 |                 52000 |        58 | t           | c          | RECORD    | X             | GRANTED     | 15, 15    |
		| 139668065921640:12:5:6:139667974448840 |                 52000 |        58 | t           | c          | RECORD    | X             | GRANTED     | 20, 20    |
		| 139668065921640:12:5:7:139667974448840 |                 52000 |        58 | t           | c          | RECORD    | X             | GRANTED     | 25, 25    |
		| 139668065921640:12:4:5:139667974449184 |                 52000 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 15        |
		| 139668065921640:12:4:6:139667974449184 |                 52000 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 20        |
		| 139668065921640:12:4:7:139667974449184 |                 52000 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 25        |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		9 rows in set (0.00 sec)

		
	T3

		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139668065922512:1069:139667974457832   |                 52002 |        60 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065922512:12:4:7:139667974454904 |                 52002 |        60 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 25        |
		| 139668065921640:1069:139667974451880   |                 52000 |        58 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065921640:12:5:5:139667974448840 |                 52000 |        58 | t           | c          | RECORD    | X             | GRANTED     | 15, 15    |
		| 139668065921640:12:5:6:139667974448840 |                 52000 |        58 | t           | c          | RECORD    | X             | GRANTED     | 20, 20    |
		| 139668065921640:12:5:7:139667974448840 |                 52000 |        58 | t           | c          | RECORD    | X             | GRANTED     | 25, 25    |
		| 139668065921640:12:4:5:139667974449184 |                 52000 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 15        |
		| 139668065921640:12:4:6:139667974449184 |                 52000 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 20        |
		| 139668065921640:12:4:7:139667974449184 |                 52000 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 25        |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		9 rows in set (0.00 sec)

3.4.3 用 for update 语句验证
	
	session A							session B			     session C		             				
	begin;
	mysql> select d from t where c>=15 and c<=20 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 15 |   15 |   15 |
	| 20 |   20 |   20 |
	+----+------+------+
	2 rows in set (0.00 sec)
	
	T1
							


										 begin;	
										 update t set d=d+1 where c=25;
										 (Blocked)
	T2
																  begin;		
																  update t set d=d+1 where id=25;
																  (Query Ok)
	
	
	T1
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139668065921640:1069:139667974451880   |                 52028 |        74 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065921640:12:5:5:139667974448840 |                 52028 |        74 | t           | c          | RECORD    | X             | GRANTED     | 15, 15    |
		| 139668065921640:12:5:6:139667974448840 |                 52028 |        74 | t           | c          | RECORD    | X             | GRANTED     | 20, 20    |
		| 139668065921640:12:5:7:139667974448840 |                 52028 |        74 | t           | c          | RECORD    | X             | GRANTED     | 25, 25    |
		| 139668065921640:12:4:5:139667974449184 |                 52028 |        74 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 15        |
		| 139668065921640:12:4:6:139667974449184 |                 52028 |        74 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 20        |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		6 rows in set (0.00 sec)

	T2

		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139668065922512:1069:139667974457832   |                 52029 |        73 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065922512:12:5:7:139667974454904 |                 52029 |        73 | t           | c          | RECORD    | X             | WAITING     | 25, 25    |
		
		| 139668065921640:1069:139667974451880   |                 52028 |        74 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065921640:12:5:5:139667974448840 |                 52028 |        74 | t           | c          | RECORD    | X             | GRANTED     | 15, 15    |
		| 139668065921640:12:5:6:139667974448840 |                 52028 |        74 | t           | c          | RECORD    | X             | GRANTED     | 20, 20    |
		| 139668065921640:12:5:7:139667974448840 |                 52028 |        74 | t           | c          | RECORD    | X             | GRANTED     | 25, 25    |
		| 139668065921640:12:4:5:139667974449184 |                 52028 |        74 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 15        |
		| 139668065921640:12:4:6:139667974449184 |                 52028 |        74 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 20        |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		8 rows in set (0.00 sec)
	
	

3.5  c>=15 and c<20   

3.5.1 用 lock in share mode 语句验证
 
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
															   update t set d=100 where id=20; 
															   (Query Ok)
															   
    T3

    T1
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139668065921640:1069:139667974451880   |       421143042632296 |        67 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 139668065921640:12:5:5:139667974448840 |       421143042632296 |        67 | t           | c          | RECORD    | S             | GRANTED     | 15, 15    |
		| 139668065921640:12:5:6:139667974448840 |       421143042632296 |        67 | t           | c          | RECORD    | S             | GRANTED     | 20, 20    |
		| 139668065921640:12:4:5:139667974449184 |       421143042632296 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 15        |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		4 rows in set (0.01 sec)
      
     
    T2
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139668065922512:1069:139667974457832   |                 52017 |        68 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065922512:12:5:6:139667974454904 |                 52017 |        68 | t           | c          | RECORD    | X             | WAITING     | 20, 20    |
		| 139668065921640:1069:139667974451880   |       421143042632296 |        67 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 139668065921640:12:5:5:139667974448840 |       421143042632296 |        67 | t           | c          | RECORD    | S             | GRANTED     | 15, 15    |
		| 139668065921640:12:5:6:139667974448840 |       421143042632296 |        67 | t           | c          | RECORD    | S             | GRANTED     | 20, 20    |
		| 139668065921640:12:4:5:139667974449184 |       421143042632296 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 15        |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		6 rows in set (0.00 sec)
     
    T3
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139668065922512:1069:139667974457832   |                 52018 |        68 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065922512:12:4:6:139667974454904 |                 52018 |        68 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 20        |
		| 139668065921640:1069:139667974451880   |       421143042632296 |        67 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 139668065921640:12:5:5:139667974448840 |       421143042632296 |        67 | t           | c          | RECORD    | S             | GRANTED     | 15, 15    |
		| 139668065921640:12:5:6:139667974448840 |       421143042632296 |        67 | t           | c          | RECORD    | S             | GRANTED     | 20, 20    |
		| 139668065921640:12:4:5:139667974449184 |       421143042632296 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 15        |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		6 rows in set (0.00 sec)

       
    session A的加锁范围
        加锁的基本单位是 next-key lock, c>=15 的加锁范围: c: next-key lock: (10,15]
        范围查询就需要往后找, c<20 找到 c=20 这一行会停下来, c<20 的加锁范围: c: next-key lock:(15,20]
        因此, session A的加锁范围: 
			c: next-key lock: (10,15]  + c: next-key lock:(15,20] + prmary: record lock: [15]

        分析正确了.
        并且验证了只有访问到的记录才会加锁,对主键记录进行加锁, 这里只访问到了主键 id=15 的这一行记录, 所以只会对这一行加锁.
	

3.5.2 用 update 语句验证
 
    session A                      session B                    session C
	begin;
    update t set d=100 where c>=15 and c<20;
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
															   update t set d=100 where id=20; 
															   (Blocked)
	T3 

	T1
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139668065921640:1069:139667974451880   |                 52020 |        67 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065921640:12:5:5:139667974448840 |                 52020 |        67 | t           | c          | RECORD    | X             | GRANTED     | 15, 15    |
		| 139668065921640:12:5:6:139667974448840 |                 52020 |        67 | t           | c          | RECORD    | X             | GRANTED     | 20, 20    |
		| 139668065921640:12:4:5:139667974449184 |                 52020 |        67 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 15        |
		| 139668065921640:12:4:6:139667974449184 |                 52020 |        67 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 20        |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		5 rows in set (0.00 sec)

	T2
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139668065922512:1069:139667974457832   |                 52021 |        68 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065922512:12:5:6:139667974454904 |                 52021 |        68 | t           | c          | RECORD    | X             | WAITING     | 20, 20    |
		| 139668065921640:1069:139667974451880   |                 52020 |        67 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065921640:12:5:5:139667974448840 |                 52020 |        67 | t           | c          | RECORD    | X             | GRANTED     | 15, 15    |
		| 139668065921640:12:5:6:139667974448840 |                 52020 |        67 | t           | c          | RECORD    | X             | GRANTED     | 20, 20    |
		| 139668065921640:12:4:5:139667974449184 |                 52020 |        67 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 15        |
		| 139668065921640:12:4:6:139667974449184 |                 52020 |        67 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 20        |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		7 rows in set (0.00 sec)

	T3
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139668065922512:1069:139667974457832   |                 52022 |        68 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065922512:12:4:6:139667974454904 |                 52022 |        68 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 20        |
		| 139668065921640:1069:139667974451880   |                 52020 |        67 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139668065921640:12:5:5:139667974448840 |                 52020 |        67 | t           | c          | RECORD    | X             | GRANTED     | 15, 15    |
		| 139668065921640:12:5:6:139667974448840 |                 52020 |        67 | t           | c          | RECORD    | X             | GRANTED     | 20, 20    |
		| 139668065921640:12:4:5:139667974449184 |                 52020 |        67 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 15        |
		| 139668065921640:12:4:6:139667974449184 |                 52020 |        67 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 20        |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		7 rows in set (0.00 sec)
		
3.5.3 用 for update 语句验证

    session A                      session B                    session C
    select d from t where c>=15 and c<20 for update;
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
															   update t set d=100 where id=20; 
															   (Query Ok)
	
	T1
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139668065921640:1069:139667974451880   |                 52024 |        74 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139668065921640:12:5:5:139667974448840 |                 52024 |        74 | t           | c          | RECORD    | X             | GRANTED     | 15, 15    |
	| 139668065921640:12:5:6:139667974448840 |                 52024 |        74 | t           | c          | RECORD    | X             | GRANTED     | 20, 20    |
	| 139668065921640:12:4:5:139667974449184 |                 52024 |        74 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 15        |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	4 rows in set (0.00 sec)
	
	T2
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139668065922512:1069:139667974457832   |                 52025 |        73 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139668065922512:12:5:6:139667974454904 |                 52025 |        73 | t           | c          | RECORD    | X             | WAITING     | 20, 20    |
	| 139668065921640:1069:139667974451880   |                 52024 |        74 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139668065921640:12:5:5:139667974448840 |                 52024 |        74 | t           | c          | RECORD    | X             | GRANTED     | 15, 15    |
	| 139668065921640:12:5:6:139667974448840 |                 52024 |        74 | t           | c          | RECORD    | X             | GRANTED     | 20, 20    |
	| 139668065921640:12:4:5:139667974449184 |                 52024 |        74 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 15        |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	6 rows in set (0.00 sec)

	
	
3.6 小结

	
	
	c>=15 and c<=20的加锁范围
		lock in share mode模式
			加锁的基本单位是 next-key lock, c>=15 的加锁范围: c: next-key lock: (10,15]
			c<=20 找到 c=20, c<20 的加锁范围: c: next-key lock:(15,20]
			范围查询就需要往后找, 找到 c=25 的记录才会停止下来, 这里用不到优化规则, 所以 加锁范围是 c: next-key lock: (20, 25]
			因此, session A的加锁范围: 
					c: next-key lock: (10,15]  + c: next-key lock:(15,20] + c: next-key lock: (20, 25] +
					prmary: record lock: [15] + prmary: record lock: [20]
			
			至于为什么会锁住 c=25这一行记录，是因为 c<=20 是范围查询，范围查询就需要往后找，直到找到不满足条件的第一个值为止，所以找到 c=25 这一行，但是这里又不是等值查询，所以用不到优化2.
			
		update 语句
			加锁的基本单位是 next-key lock, c>=15 的加锁范围: c: next-key lock: (10,15]
			c<=20 找到 c=20, c<20 的加锁范围: c: next-key lock:(15,20]
			范围查询就需要往后找, 找到 c=25 的记录才会停止下来, 这里用不到优化规则, 所以 加锁范围是 c: next-key lock: (20, 25]
			因此, session A的加锁范围: 
					c: next-key lock: (10,15]  + c: next-key lock:(15,20] + c: next-key lock: (20, 25] +
					prmary: record lock: [15] + prmary: record lock: [20]+ prmary: record lock: [25]
					
	------------------------------------------------------------------------------------------------------------------------		
	
	c>=15 and c<20的加锁范围
		lock in share mode模式
			加锁的基本单位是 next-key lock, c>=15 的加锁范围: c: next-key lock: (10,15]
			范围查询就需要往后找, c<20 找到 c=20 这一行会停下来, c<20 的加锁范围: c: next-key lock:(15,20]
			因此, session A的加锁范围: 
				c: next-key lock: (10,15]  + c: next-key lock:(15,20] + 
				prmary: record lock: [15]

			分析正确了.
			并且验证了只有访问到的记录才会加锁,对主键记录进行加锁, 这里只访问到了主键 id=15 的这一行记录, 所以只会对这一行加锁.
			
		update 语句
	
			加锁的基本单位是 next-key lock, c>=15 的加锁范围: c: next-key lock: (10,15]
			范围查询就需要往后找, c<20 找到 c=20 这一行会停下来, c<20 的加锁范围: c: next-key lock:(15,20]
			因此, session A的加锁范围: 
				c: next-key lock: (10,15]  + c: next-key lock:(15,20] + 
				prmary: record lock: [15] + prmary: record lock: [20] 
	
	
	范围加锁：
		lock in share mode模式和for update模式，对不满足条件的二级索引记录加锁，不需要回到主键索引记录上加锁。
		update语句，对不满足条件的二级索引记录加锁，需要回到主键索引记录上加锁。
			-- delete 语句呢
			
	

4. 其它相关参考
	


	