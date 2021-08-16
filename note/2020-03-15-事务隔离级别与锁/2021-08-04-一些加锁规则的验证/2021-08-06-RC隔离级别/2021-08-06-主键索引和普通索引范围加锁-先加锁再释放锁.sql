
1. 表结构和数据的初始化
2. 主键索引范围锁
	2.0 用lock in share mode语句验证
	2.1 先范围查询加锁再等值查询加锁
	2.2 先等值查询加锁再范围查询加锁
	
3. 二级索引等值锁
	--不再需要向遍历到不满足条件的第一个值为止
	
4. 二级索引等值范围锁
	4.1 用lock in share mode语句验证
		4.1.1 先等值范围查询加锁再等值查询加锁
		4.1.2 先根据主键索引更新数据再等值范围查询加锁

	4.2 用update和delete语句验证	
		4.2.1 先根据主键索引等值加锁再普通索引等值范围更新加锁
		4.2.2 先根据主键索引等值加锁再普通索引等值范围删除加锁

	4.3 等值范围更新加锁
		4.3.1 验证是否会对不满足条件的第一个值先进行加锁再释放锁
		4.3.2 验证是否会对不满足条件的第一个值对应的主键值进行加锁再释放锁
		4.3.3 验证是否会对不满足条件的第一个值对应的主键值进行加锁再释放锁
		
5. 全表扫描
	5.1 先全表扫描再根据主键索引删除数据加锁
	5.2 根据主键索引删除数据加锁再先全表扫描
	

6. 证明RC隔离级别下先加锁再退化释放锁的实验--同时证明lock in share mode模式的范围等值查询加锁会有尾点延伸的问题
	6.1 初始表结构和数据初始化	
	6.2 现象和我的问题
	6.3 MySQL 8.0.17版本下做验证
	6.4 MySQL 8.0.18版本做验证

7. 小结
12. 实践指导意义


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
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.00 sec)

2. 主键索引范围锁

	2.1 先范围查询加锁再等值查询加锁
		session A               session B
		BEGIN;
		SELECT * FROM hero WHERE number <= 8 LOCK IN SHARE MODE;
		+--------+------------+---------+
		| number | name       | country |
		+--------+------------+---------+
		|      1 | l刘备      | 蜀      |
		|      3 | z诸葛亮    | 蜀      |
		|      8 | c曹操      | 魏      |
		+--------+------------+---------+
		3 rows in set (0.00 sec)

								BEGIN;
								SELECT * FROM hero WHERE number = 15 FOR UPDATE;
								(Query OK)

		root@mysqldb 17:37:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140565258469648:1168:140565152866040  |                  5428 |        66 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 140565258469648:8:4:5:140565152863160 |                  5428 |        66 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 15        |
		| 140565258468784:1168:140565152860056  |       422040235179440 |        65 | hero        | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 140565258468784:8:4:2:140565152857128 |       422040235179440 |        65 | hero        | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
		| 140565258468784:8:4:3:140565152857128 |       422040235179440 |        65 | hero        | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
		| 140565258468784:8:4:4:140565152857128 |       422040235179440 |        65 | hero        | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 8         |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		6 rows in set (0.09 sec)


	2.2 先等值查询加锁再范围查询加锁
		
		session A               session B
		BEGIN;
		SELECT * FROM hero WHERE number = 15 FOR UPDATE;
		+--------+---------+---------+
		| number | name    | country |
		+--------+---------+---------+
		|     15 | x荀彧   | 魏      |
		+--------+---------+---------+
		1 row in set (0.00 sec)
								
								BEGIN;
								SELECT * FROM hero WHERE number <= 8 LOCK IN SHARE MODE;
								(BLocked)

		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140565258468784:1168:140565152860056  |                  5429 |        65 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 140565258468784:8:4:5:140565152857128 |                  5429 |        65 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 15        |
		| 140565258469648:1168:140565152866040  |       422040235180304 |        66 | hero        | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 140565258469648:8:4:2:140565152863160 |       422040235180304 |        66 | hero        | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
		| 140565258469648:8:4:3:140565152863160 |       422040235180304 |        66 | hero        | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
		| 140565258469648:8:4:4:140565152863160 |       422040235180304 |        66 | hero        | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 8         |
		| 140565258469648:8:4:5:140565152863504 |       422040235180304 |        66 | hero        | PRIMARY    | RECORD    | S,REC_NOT_GAP | WAITING     | 15        |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		7 rows in set (0.00 sec)
		
		
		session B 的加锁过程之一: 
			
			因为这里是范围等值查询, 需要访问到 id=15 才会停止下来, 所以需要申请 id=15 的记录加锁, 因此被 session A 阻塞. 
			假设没有 session A 这个事务, 并且 id=15 在RC级别下没有别的事务锁住，所以 session B 会把 id=15 的记录锁释放.
			如果对不满足条件的行上的行锁加锁的时候, 如果该行锁已经被别的事务持有,那么就会被阻塞.
			也就是说在RC隔离级别下，访问到的记录都会加锁，然后会把不符合条件的锁释放掉.
	
		---------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		-- 把 lock in share mode 改为 update语句验证如下
		
		session A               session B
		BEGIN;
		SELECT * FROM hero WHERE number = 15 FOR UPDATE;
	
								BEGIN;
								update hero set country="a" where  number <= 8;
								(Query OK)
		
			
3. 二级索引等值锁

	-- 等值查询, 不再需要向遍历到不满足条件的第一个值为止.
	
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
	
	session A           session B
	begin;
	SELECT * FROM hero WHERE name = 'c曹操' LOCK IN SHARE MODE;
	+--------+---------+---------+
	| number | name    | country |
	+--------+---------+---------+
	|      8 | c曹操   | 魏      |
	+--------+---------+---------+
	1 row in set (0.00 sec)
						
						begin;
						UPDATE hero SET name = '曹操' WHERE number = 8;
						(Blocked)
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
	| 140349534318000:1168:140349464971160  |                  6408 |        59 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
	| 140349534318000:8:4:4:140349464968232 |                  6408 |        59 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 8            |
	
	| 140349534317136:1168:140349464965208  |       421824511027792 |        58 | hero        | NULL       | TABLE     | IS            | GRANTED     | NULL         |
	| 140349534317136:8:5:4:140349464962168 |       421824511027792 |        58 | hero        | idx_name   | RECORD    | S,REC_NOT_GAP | GRANTED     | 'c曹操', 8   |
	| 140349534317136:8:4:4:140349464962512 |       421824511027792 |        58 | hero        | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 8            |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
	5 rows in set (0.05 sec)
	

	session A的加锁流程:
		先对name列为'c曹操'二级索引记录进行加锁。
		再对相应的聚簇索引记录进行加锁
		
	session B的加锁流程:
		先对主键索引的 number=8 的记录加锁
		再对 name='c曹操' 的二级索引记录加锁
		
	session A和session B 的加锁规则不一致, 会导致死锁发生, 如下所示
	
		session A       						 session B
		
		持有二级索引 name = 'c曹操'  的记录锁
												持有主键索引  number=8 的记录锁
		等待持有主键索引 number=8 的记录锁
												等待持有二级索引 name = 'c曹操'  的记录锁
		
		
		死锁: 两个事务都分别持有一个锁，而且都在等待对方已经持有的那个锁，这种情况就是所谓的死锁，两个事务都无法运行下去，必须选择一个进行回滚。  
	
	----------------------------------------
	
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
	
	session A           session B
	begin;
	update hero set country="蜀1" where name="l刘备";
	
						begin;
						SELECT * FROM hero WHERE name = 'c曹操' for update;
						+--------+---------+---------+
						| number | name    | country |
						+--------+---------+---------+
						|      8 | c曹操   | 魏      |
						+--------+---------+---------+
						1 row in set (0.00 sec)
	
	----------------------------------------------------------------------
	
	session A          session B 
	begin;
	update hero set country="蜀1" where name="l刘备";	
	Query OK, 1 row affected (0.00 sec)
	Rows matched: 1  Changed: 1  Warnings: 0

						begin;
						update hero set name = 'c曹操' where name = 'c曹操';
						Query OK, 0 rows affected (0.00 sec)
						Rows matched: 1  Changed: 0  Warnings: 0
												
	
	-- 等值查询, 不再需要向遍历到不满足条件的第一个值为止.

	
4. 二级索引等值范围锁

4.1 用lock in share mode语句验证

4.1.1 先等值范围查询加锁再等值查询加锁

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
										
	session A       	 session B									
	begin;
	SELECT * FROM hero FORCE INDEX(idx_name) WHERE name <= 'c曹操' LOCK IN SHARE MODE;
	+--------+---------+---------+
	| number | name    | country |
	+--------+---------+---------+
	|      8 | c曹操   | 魏      |
	+--------+---------+---------+
	1 row in set (0.00 sec)
	T1

						begin;
	T2					SELECT * FROM hero WHERE name = 'l刘备' FOR UPDATE;    
						(Blocked)
	
	T1
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
		| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
		| 140349534318000:1168:140349464971160  |       421824511028656 |        62 | hero        | NULL       | TABLE     | IS            | GRANTED     | NULL         |
		| 140349534318000:8:5:2:140349464968232 |       421824511028656 |        62 | hero        | idx_name   | RECORD    | S,REC_NOT_GAP | GRANTED     | 'l刘备', 1   |
		| 140349534318000:8:5:4:140349464968232 |       421824511028656 |        62 | hero        | idx_name   | RECORD    | S,REC_NOT_GAP | GRANTED     | 'c曹操', 8   |
		| 140349534318000:8:4:4:140349464968576 |       421824511028656 |        62 | hero        | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 8            |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
		4 rows in set (0.01 sec)				
	
	T2
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
		| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
		| 140349534317136:1168:140349464965208  |                  6409 |        61 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
		| 140349534317136:8:5:2:140349464962168 |                  6409 |        61 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | WAITING     | 'l刘备', 1   |
		
		| 140349534318000:1168:140349464971160  |       421824511028656 |        62 | hero        | NULL       | TABLE     | IS            | GRANTED     | NULL         |
		| 140349534318000:8:5:2:140349464968232 |       421824511028656 |        62 | hero        | idx_name   | RECORD    | S,REC_NOT_GAP | GRANTED     | 'l刘备', 1   |
		| 140349534318000:8:5:4:140349464968232 |       421824511028656 |        62 | hero        | idx_name   | RECORD    | S,REC_NOT_GAP | GRANTED     | 'c曹操', 8   |
		| 140349534318000:8:4:4:140349464968576 |       421824511028656 |        62 | hero        | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 8            |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
		6 rows in set (0.01 sec)
						
						update hero set name = 'l刘备' where number=1;
						(Query OK)。
		
	session A 的加锁范围:
		idx_name: record lock: (name='c曹操', id=8)
		primary:  record lock: (id=8)
		idx_name: record lock: (name='l刘备', id=1)
	

	--------------------------------------------------------------------------------------------------------------------------------------------------------------------

4.1.2 先根据主键索引更新数据再等值范围查询加锁

	session A       								
	begin;
	SELECT * FROM hero FORCE INDEX(idx_name) WHERE name <= 'c曹操' LOCK IN SHARE MODE;
	
	思考: session A 是否会对 number=1 的记录加锁?
	
		答: 不会，因为普通索引是范围查询加锁。

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
			
		用lock in share mode语句验证如下
			session A        session B		
			begin;
			SELECT * FROM hero WHERE number=1 FOR UPDATE;
			+--------+---------+---------+
			| number | name    | country |
			+--------+---------+---------+
			|      1 | l刘备   | 蜀      |
			+--------+---------+---------+
			1 row in set (0.00 sec)
			
							begin;
							SELECT * FROM hero FORCE INDEX(idx_name) WHERE name <= 'c曹操' LOCK IN SHARE MODE;
							+--------+---------+---------+
							| number | name    | country |
							+--------+---------+---------+
							|      8 | c曹操   | 魏      |
							+--------+---------+---------+
							1 row in set (0.11 sec)
							
							

		用for update语句验证如下
			session A        session B		
			begin;
			SELECT * FROM hero WHERE number=1 FOR UPDATE;
			+--------+---------+---------+
			| number | name    | country |
			+--------+---------+---------+
			|      1 | l刘备   | 蜀      |
			+--------+---------+---------+
			1 row in set (0.00 sec)
			
							begin;
							SELECT * FROM hero FORCE INDEX(idx_name) WHERE name <= 'c曹操' for update; 
							+--------+---------+---------+
							| number | name    | country |
							+--------+---------+---------+
							|      8 | c曹操   | 魏      |
							+--------+---------+---------+
							1 row in set (0.00 sec)	
							
			
		-----------------------------------------------------------------------------------------------------------------------------

4.2 用update和delete语句验证
		
		4.2.1 先根据主键索引等值加锁再普通索引等值范围更新加锁
		
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
			
			session A       session B		
			begin;
			SELECT * FROM hero WHERE number=1 FOR UPDATE;
			+--------+---------+---------+
			| number | name    | country |
			+--------+---------+---------+
			|      1 | l刘备   | 蜀      |
			+--------+---------+---------+
			1 row in set (0.00 sec)
			
							begin;
							update hero set name = 'c曹操' where name <= 'c曹操';
							(Blocked)
							--同时验证了原地更新并且更新前和更新后的值一样，照样加锁。
							
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
			| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
			| 140349534317136:1168:140349464965208  |                  6434 |        72 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
			| 140349534317136:8:5:2:140349464962168 |                  6434 |        72 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | GRANTED     | 'l刘备', 1   |
			| 140349534317136:8:5:4:140349464962168 |                  6434 |        72 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | GRANTED     | 'c曹操', 8   |
			| 140349534317136:8:4:4:140349464962512 |                  6434 |        72 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 8            |
			| 140349534317136:8:4:2:140349464962856 |                  6434 |        72 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 1            |  
			-- 被主键索引 id=1 的记录锁阻塞。
			| 140349534318000:1168:140349464971160  |                  6432 |        71 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
			| 140349534318000:8:4:2:140349464968232 |                  6432 |        71 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1            |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
			7 rows in set (0.05 sec)
			
			
			-----------------------------------------------------------------------------------------------------------------------------------------------------------------
			
		4.2.2 先根据主键索引等值加锁再普通索引等值范围删除加锁
				
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
						
			session A       	session B		
			begin;
			
			SELECT * FROM hero WHERE number=1 FOR UPDATE;
			+--------+---------+---------+
			| number | name    | country |
			+--------+---------+---------+
			|      1 | l刘备   | 蜀      |
			+--------+---------+---------+
			1 row in set (0.00 sec)

								begin;
								delete from hero where name <= 'c曹操';
								(Blocked)
								
								
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
			| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
			| 140349534318000:1168:140349464971160  |                  6445 |        77 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
			| 140349534318000:8:5:2:140349464968232 |                  6445 |        77 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | GRANTED     | 'l刘备', 1   |
			| 140349534318000:8:5:4:140349464968232 |                  6445 |        77 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | GRANTED     | 'c曹操', 8   |
			| 140349534318000:8:4:4:140349464968576 |                  6445 |        77 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 8            |
			
			| 140349534318000:8:4:2:140349464968920 |                  6445 |        77 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 1            |
			
			| 140349534317136:1168:140349464965208  |                  6444 |        76 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
			| 140349534317136:8:4:2:140349464962168 |                  6444 |        76 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1            |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
			7 rows in set (0.00 sec)
	
	
	各自的执行计划		
		mysql> desc SELECT * FROM hero FORCE INDEX(idx_name) WHERE name <= 'c曹操' LOCK IN SHARE MODE;
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+-----------------------+
		| id | select_type | table | partitions | type  | possible_keys | key      | key_len | ref  | rows | filtered | Extra                 |
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+-----------------------+
		|  1 | SIMPLE      | hero  | NULL       | range | idx_name      | idx_name | 403     | NULL |    1 |   100.00 | Using index condition |
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+-----------------------+
		1 row in set, 1 warning (0.00 sec)
	
		mysql> desc SELECT * FROM hero FORCE INDEX(idx_name) WHERE name <= 'c曹操';
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+-----------------------+
		| id | select_type | table | partitions | type  | possible_keys | key      | key_len | ref  | rows | filtered | Extra                 |
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+-----------------------+
		|  1 | SIMPLE      | hero  | NULL       | range | idx_name      | idx_name | 403     | NULL |    1 |   100.00 | Using index condition |
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+-----------------------+
		1 row in set, 1 warning (0.00 sec)		

		mysql> desc delete from hero where name <= 'c曹操';
		+----+-------------+-------+------------+-------+---------------+----------+---------+-------+------+----------+-------------+
		| id | select_type | table | partitions | type  | possible_keys | key      | key_len | ref   | rows | filtered | Extra       |
		+----+-------------+-------+------------+-------+---------------+----------+---------+-------+------+----------+-------------+
		|  1 | DELETE      | hero  | NULL       | range | idx_name      | idx_name | 403     | const |    1 |   100.00 | Using where |
		+----+-------------+-------+------------+-------+---------------+----------+---------+-------+------+----------+-------------+
		1 row in set, 1 warning (0.00 sec)

		mysql> desc update hero set name = '曹操' where name <= 'c曹操';
		+----+-------------+-------+------------+-------+---------------+----------+---------+-------+------+----------+------------------------------+
		| id | select_type | table | partitions | type  | possible_keys | key      | key_len | ref   | rows | filtered | Extra                        |
		+----+-------------+-------+------------+-------+---------------+----------+---------+-------+------+----------+------------------------------+
		|  1 | UPDATE      | hero  | NULL       | range | idx_name      | idx_name | 403     | const |    1 |   100.00 | Using where; Using temporary |
		+----+-------------+-------+------------+-------+---------------+----------+---------+-------+------+----------+------------------------------+
		1 row in set, 1 warning (0.00 sec)
		

		
4.3 等值范围更新加锁		

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
	
	UPDATE hero SET country = '汉' WHERE name <= 'c曹操';
	
	语句的加锁过程:
	
		先锁住比idx_name索引页的最小值还要小的 Infimum 记录值
		
		再对name <= 'c曹操'的记录加锁: idx_name: record lock: (name='c曹操',number=8), 同时锁住对应的主键: primary: record lock:[8]
		
		普通索引的范围等值查询, 需要查找到不满足条件的第一行记录为止并加锁, idx_name: record lock: (name='l刘备',number=1) + primary: record lock:[1]
		
		接着开始释放锁: 
				
			释放 Infimum 锁
			释放 idx_name: record lock: (name='l刘备',number=1) + primary: record lock:[1] 锁.
			
		因此, 语句的加锁范围为  idx_name: record lock: (name='c曹操',number=8) +  primary: record lock:[8]
		
		
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
	| 140349534317136:1168:140349464965208  |                  6447 |        81 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
	| 140349534317136:8:5:4:140349464962168 |                  6447 |        81 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | GRANTED     | 'c曹操', 8   |
	| 140349534317136:8:4:4:140349464962512 |                  6447 |        81 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 8            |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
	3 rows in set (0.00 sec)	
	
	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	4.3.1 验证是否会对不满足条件的第一个值先进行加锁再释放锁
		-- 会的，先加锁再释放锁。
		session A            session B
		begin;
		UPDATE hero SET country = '汉' WHERE name <= 'c曹操';
							
							 BEGIN;
							 delete from hero where name='l刘备';
							 (Query OK)
							 
		----------------------------------------------------------------------
		
		session A            session B
		begin;
		delete from hero where name='l刘备';
							
							 begin;	
							 UPDATE hero SET country = '汉' WHERE name <= 'c曹操';
							 (Blocked)
							 
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
		| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
		| 139835056598480:1062:139834941311464  |                  3669 |        71 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
		| 139835056598480:5:5:4:139834941308536 |                  3669 |        71 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | GRANTED     | 'c曹操', 8   |
		| 139835056598480:5:4:4:139834941308880 |                  3669 |        71 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 8            |
		| 139835056598480:5:5:2:139834941309224 |                  3669 |        71 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | WAITING     | 'l刘备', 1   |
		-- 被二级索引 name='l刘备' 的记录锁阻塞。
		| 139835056597608:1062:139834941305512  |                  3668 |        70 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
		| 139835056597608:5:5:2:139834941302472 |                  3668 |        70 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | GRANTED     | 'l刘备', 1   |
		| 139835056597608:5:4:9:139834941302816 |                  3668 |        70 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1            |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
		7 rows in set (0.00 sec)

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	4.3.2 验证是否会对不满足条件的第一个值对应的主键值进行加锁再释放锁
		
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
		
			session A 			session B
			begin;
			delete from hero where number=1;
								
								begin;
								UPDATE hero SET country = '汉' WHERE name <= 'c曹操';
								(Blocked)
			
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
			| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
			| 140349534318000:1168:140349464971160  |                  6459 |        83 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
			| 140349534318000:8:5:4:140349464968232 |                  6459 |        83 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | GRANTED     | 'c曹操', 8   |
			| 140349534318000:8:4:4:140349464968576 |                  6459 |        83 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 8            |
			| 140349534318000:8:5:2:140349464968920 |                  6459 |        83 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | WAITING     | 'l刘备', 1   |
			-- 被二级索引 name='l刘备' 的记录锁阻塞。
			| 140349534317136:1168:140349464965208  |                  6458 |        81 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
			| 140349534317136:8:4:2:140349464962168 |                  6458 |        81 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1            |
			| 140349534317136:8:5:2:140349464962512 |                  6458 |        83 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | GRANTED     | 'l刘备', 1   |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
			7 rows in set (0.00 sec)
			
	4.3.3 验证是否会对不满足条件的第一个值对应的主键值进行加锁再释放锁
		
		-- 会的，先加锁再释放锁。
		session A 			session B
		begin;
		update hero set country="日" where number=1;
								
								begin;
								UPDATE hero SET country = '汉' WHERE name <= 'c曹操';
								(Blocked)
		
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
		| 139835056597608:1062:139834941305512   |                  3891 |       159 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
		| 139835056597608:5:5:2:139834941302472  |                  3891 |       159 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | GRANTED     | 'l刘备', 1   |
		| 139835056597608:5:5:4:139834941302472  |                  3891 |       159 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | GRANTED     | 'c曹操', 8   |
		| 139835056597608:5:4:10:139834941302816 |                  3891 |       159 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 8            |
		| 139835056597608:5:4:12:139834941303160 |                  3891 |       159 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 1            |
		-- 被主键索引 number=1 的记录锁阻塞。
		| 139835056598480:1062:139834941311464   |                  3890 |       160 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
		| 139835056598480:5:4:12:139834941308536 |                  3890 |       160 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1            |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
		7 rows in set (0.00 sec)

		
5. 全表扫描
	
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
	
	
5.1 先全表扫描再根据主键索引删除数据加锁
	
	session A          session B
	begin;
	SELECT * FROM hero WHERE country  = '魏' LOCK IN SHARE MODE;
	+--------+---------+---------+
	| number | name    | country |
	+--------+---------+---------+
	|      8 | c曹操   | 魏      |
	|     15 | x荀彧   | 魏      |
	+--------+---------+---------+
	2 rows in set (0.00 sec)
	
	T1
		
						begin;
						delete from hero where number=1;
						(Query OK)

						mysql> select * from hero;
						+--------+------------+---------+
						| number | name       | country |
						+--------+------------+---------+
						|      3 | z诸葛亮    | 蜀      |
						|      8 | c曹操      | 魏      |
						|     15 | x荀彧      | 魏      |
						|     20 | s孙权      | 吴      |
						+--------+------------+---------+
						4 rows in set (0.00 sec)
	
	T1
	
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140716802124368:1168:140716684669016  |       422191778835024 |        58 | hero        | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 140716802124368:8:4:4:140716684665976 |       422191778835024 |        58 | hero        | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 8         |
		| 140716802124368:8:4:5:140716684665976 |       422191778835024 |        58 | hero        | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 15        |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		3 rows in set (0.03 sec)
			
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
5.2 根据主键索引删除数据加锁再先全表扫描
	

	session A          session B
	begin;
	delete from hero where number=1;
						
						begin;
						SELECT * FROM hero WHERE country  = '魏' LOCK IN SHARE MODE;					
						(Blocked)

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140349534317136:1168:140349464965208  |                  6468 |        88 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140349534317136:8:4:2:140349464962168 |                  6468 |        88 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
	| 140349534318000:1168:140349464971160  |       421824511028656 |        87 | hero        | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140349534318000:8:4:2:140349464968232 |       421824511028656 |        87 | hero        | PRIMARY    | RECORD    | S,REC_NOT_GAP | WAITING     | 1         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	4 rows in set (0.00 sec)
	


6. 证明RC隔离级别下先加锁再退化释放锁的实验--同时证明lock in share mode模式的范围等值查询加锁会有尾点延伸的问题
		
6.1 初始表结构和数据初始化	
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('2', '2', '2');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('3', '3', '3');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('4', '4', '4');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('5', '5', '5');
	
6.2 现象和我的问题
	
	事务的执行次序
		session A           session B
		begin;	            
		INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');  
		
							begin;	  
							SELECT * from t WHERE ((`id` >= '1')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
							
	现象:
		在MySQL 8.0.17版本和MySQL 8.0.18版本中, 在 RC读已提交隔离级别下, session B都会被阻塞.
		
		这个现象的实验在 '3.1 事务隔离级别为RC读已提交' 和 '4.1 事务隔离级别为RC读已提交' 中.
		
	我的问题:
		
		在RC读已提交隔离级别下, session B 为什么会被阻塞？
		
		RC隔离级别下先加锁再退化释放锁。
		
		
	姜少华的解答：
	
		1.insert的通过自增加的隐式锁       
		2.第二个语句是锁的过程实际上是id<=5的下一条记录也就是这个页的最大记录（如果这个在RC级别下没有被别的事务持有锁，则会立即释放）
		举个例子  id 1，3，5   
		在RC级别下 select * from table where id<=3 实际上加锁的过程是1 3 5(这个随后释放掉)   最终加锁1 3


6.3 MySQL 8.0.17版本做验证

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.17    |
	+-----------+
	1 row in set (0.00 sec)
	
6.3.1 事务隔离级别为RC读已提交
	
	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.00 sec)
	
	事务的执行次序
	session A           session B

	begin;	            
	INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');  							
						begin;	  
						SELECT * from t WHERE ((`id` >= '1')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
						(Blocked)
	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140412282083920:1059:140412211753048  |                  4343 |        65 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140412282083920:2:4:7:140412211750008 |                  4343 |        66 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 6         |
	| 140412282084784:1059:140412211759000  |       421887258795440 |        66 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140412282084784:2:4:2:140412211756072 |       421887258795440 |        66 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 140412282084784:2:4:3:140412211756072 |       421887258795440 |        66 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 140412282084784:2:4:4:140412211756072 |       421887258795440 |        66 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140412282084784:2:4:5:140412211756072 |       421887258795440 |        66 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 140412282084784:2:4:6:140412211756072 |       421887258795440 |        66 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 5         |
	| 140412282084784:2:4:7:140412211756416 |       421887258795440 |        66 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | WAITING     | 6         |
	-- 被主键索引 id=6 的记录锁阻塞。
 	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)

	session A 持有 id=6 的行锁
	session B 是范围查询的当前读，想持有 id=6 的行锁，处于等待状态中。
		-- lock in share mode 范围等值查询加锁，会有尾点延伸的问题。
		
6.4 MySQL 8.0.18版本做验证

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)
	
6.4.1 事务隔离级别为RC读已提交

	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.00 sec)
	
	事务的执行次序
	session A           session B

	begin;	            
	INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');
	Query OK, 1 row affected (0.00 sec)	
						begin;	  
						SELECT * from t WHERE ((`id` >= '1')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
						(Blocked, 被阻塞)
						
									
	通过 performance_schema.data_locks 视图查看锁数据详情					
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140570760522344:1338:140570655781544    |               1005113 |        66 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140570760522344:281:4:7:140570655778504 |               1005113 |        67 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 6         |

	| 140570760523216:1338:140570655787496    |       422045737233872 |        67 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140570760523216:281:4:2:140570655784568 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 140570760523216:281:4:3:140570655784568 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 140570760523216:281:4:4:140570655784568 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140570760523216:281:4:5:140570655784568 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 140570760523216:281:4:6:140570655784568 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 5         |
	| 140570760523216:281:4:7:140570655784912 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | WAITING     | 6         |
	-- 被主键索引 id=6 的记录锁阻塞。
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)
	
	session A 持有 id=6 的行锁
	session B 是范围查询的当前读，想持有 id=6 的行锁，处于等待状态中。
	
	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	事务的执行次序
	session A           session B

	begin;	            
	INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');	
	
						begin;
						update t set d=100 where ((`id` >= '1')) AND ((`id` <= '5'));
						(Query Ok)
	
	
7. 小结

	1. 关于ICP索引下推
		索引条件下推（ Index Condition Pushdown，简称ICP）的功能，也就是把查询中与被使用索引有关的查询条件下推到存储引擎中判断，而不是返回到server层再判断
		索引条件下推只是为了减少回表次数，也就是减少读取完整的聚簇索引记录的次数，从而减少IO操作。
		对于聚簇索引而言不需要回表，它本身就包含着全部的列，也起不到减少IO操作的作用，所以设计InnoDB的大叔们规定这个索引条件下推特性只适用于二级索引。
		索引下推只能用于二级索引, 并且是针对select查询有效.
		
	
	2. 虽然做实验、做总结会比较耗时一点, 但是为了掌握得更好和复习, 必须是要做总结的.
	
	
	3. 实践中的指导意义

		少用范围更新，可以先根据二级索引把数据查询出来，再根据主键ID进行等值更新。
	
	
	
	
		
