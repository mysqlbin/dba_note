
1. 表结构和数据的初始化
2. 主键索引范围锁
3. 二级索引等值锁
4. 二级索引等值范围锁
	4.1 实验1
	4.2 实验2
5. 全表扫描	
	5.1 实验1	
	5.2 实验2	
	5.3 实验小结
6. 小结
7. 证明RC隔离级别下先加锁再退化释放锁的实验
	7.1 表结构和数据的初始
	7.2 实验1
	7.3 实验2
	7.5 小结
	7.6 思考
8. 证明RC隔离级别下先加锁再退化释放锁的实验 --基于主键索引范围等值查询
	8.1 初始化表结构和数据 
	8.2 实验1
	8.3 实验2	

9. 验证RC隔离级别是否存在唯一范围bug
	9.1 初始化表结构和数据
	9.2 环境 
	9.3 实验1
	9.4 实验2
	9.5 实验3
	9.6 小结

10. 证明RC隔离级别下先加锁再退化释放锁的实验
	10.1 初始表结构和数据初始化
	10.2 现象和我的问题
	10.3 MySQL 8.0.17版本
		10.3.1 事务隔离级别为RC读已提交
	10.4 MySQL 8.0.18版本
		10.4.1 事务隔离级别为RC读已提交
	
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


	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.00 sec)

2. 主键索引范围锁

	2.1 实验1-没有阻塞
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


	2.2 实验2-有阻塞
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
			也就是说找到的记录都会加锁，不符合加锁规则的就释放掉.

			
3. 二级索引等值锁

	等值查询, 不再需要向遍历到不满足条件的第一个值为止.
	
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
						
	root@mysqldb 18:15:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
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
	
		session A        session B
		
		持有二级索引 name = 'c曹操'  的记录锁
						 持有主键索引  number=8 的记录锁
		等待持有主键索引 number=8 的记录锁
						 等待持有二级索引 name = 'c曹操'  的记录锁
		
		
		死锁: 两个事务都分别持有一个锁，而且都在等待对方已经持有的那个锁，这种情况就是所谓的死锁，两个事务都无法运行下去，必须选择一个进行回滚，对性能影响比较大。  
		
		
4. 二级索引等值范围锁

4.1 实验1
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
						
	
	session A 的加锁过程:
	
		RC隔离级别:
			普通索引的范围等值查询, 需要访问到不满足条件的第一个值为止, 并且需要加锁, 不会立即把该锁释放掉.
				类似于RR隔离级别下的唯一索引范围bug
				
				如果是更新语句(update/delete), 需要回到主键索引上进行加锁.
				
				参考笔记: 
					本案例的 "4. 二级索引等值范围锁" 
					投稿文章 https://mp.weixin.qq.com/s/oWXr68fBfWJcxKLL4V_IUw  一次死锁的过程分析
					"如果 session B 是更新语句, 那就不一样了"
				
			如果是主键索引的范围等值查询,也是需要访问到不满足条件的第一个值为止, 并且需要加锁, 判断该记录不符合等值条件，又要释放掉这条记录的锁. 
				
			
		
		会为name值为'c曹操'和'l刘备'的二级索引记录以及'c曹操'对应的聚簇索引进行加锁。
		
		
	session A 的加锁范围:
		idx_name: record lock: (name='c曹操', id=8)
		primary:  record lock: (id=8)
		idx_name: record lock: (name='l刘备', id=1)
		
		
	RR隔离级别也会这样吗
	
	
	思考: session A 是否会对 number=1 的记录加锁?
	
		答: 不会.
		
		验证如下
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
							
							

			或者这样验证
				session A           session B		
				begin;
				SELECT * FROM hero FORCE INDEX(idx_name) WHERE name <= 'c曹操' LOCK IN SHARE MODE;
				+--------+---------+---------+
				| number | name    | country |
				+--------+---------+---------+
				|      8 | c曹操   | 魏      |
				+--------+---------+---------+
				1 row in set (0.00 sec)
				
				"""
				
				或者用 for update.
				SELECT * FROM hero FORCE INDEX(idx_name) WHERE name <= 'c曹操' for update;
				+--------+---------+---------+
				| number | name    | country |
				+--------+---------+---------+
				|      8 | c曹操   | 魏      |
				+--------+---------+---------+
				1 row in set (0.01 sec)
				"""
				
				T1

									begin;
									SELECT * FROM hero WHERE number = 1 FOR UPDATE;

									+--------+---------+---------+
									| number | name    | country |
									+--------+---------+---------+
									|      1 | l刘备   | 蜀      |
									+--------+---------+---------+
									1 row in set (0.00 sec)
					
			
			

							
			再或者这样验证
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
		
		如果 session B 是更新语句, 那就不一样了	
		
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
							
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
			| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
			| 140349534317136:1168:140349464965208  |                  6434 |        72 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
			| 140349534317136:8:5:2:140349464962168 |                  6434 |        72 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | GRANTED     | 'l刘备', 1   |
			| 140349534317136:8:5:4:140349464962168 |                  6434 |        72 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | GRANTED     | 'c曹操', 8   |
			| 140349534317136:8:4:4:140349464962512 |                  6434 |        72 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 8            |
			| 140349534317136:8:4:2:140349464962856 |                  6434 |        72 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 1            |
			
			| 140349534318000:1168:140349464971160  |                  6432 |        71 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
			| 140349534318000:8:4:2:140349464968232 |                  6432 |        71 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1            |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
			7 rows in set (0.05 sec)
			
							update hero set name = 'c曹操' where name <= 'c曹操';
							(Blocked)
							--原地更新照样加锁。
			
			-----------------------------------------------------------------------------------------------------------------------------------------------------------------
			
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
		
		
4.2 实验2		

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
	
		先锁住比idx_name索引页的最小值还要小的Infimum记录值
		
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
	
	验证是否会锁住不满足条件的第一个值：
	
		session A            session B
		begin;
		UPDATE hero SET country = '汉' WHERE name <= 'c曹操';
							
							 BEGIN;
							 delete from hero where name='l刘备';
							 (Query OK)
	
	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	验证是否会锁住不满足条件的第一个值对应的主键值：
	
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
		| 140349534317136:1168:140349464965208  |                  6458 |        81 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
		| 140349534317136:8:4:2:140349464962168 |                  6458 |        81 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1            |
		| 140349534317136:8:5:2:140349464962512 |                  6458 |        83 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | GRANTED     | 'l刘备', 1   |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
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
	
	
5.1 实验1	
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
	
5.2 实验2	
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
	
5.3 实验小结

	验证了读提交隔离级别下还有一个优化，即：语句执行过程中加上的行锁，在语句执行完成后，就要把 不满足条件的行 上的行锁直接释放了，不需要等到事务提交。
	
	RR隔离级别呢, SELECT * FROM hero WHERE country  = '魏' LOCK IN SHARE MODE; 是否会在语句执行结束后, 就把不符合条件的行锁释放掉
	答: 不会. 参考实验笔记 <2020-05-31-RR隔离级别下的锁.sql>
	
6. 小结
	
	1. 关于ICP索引下推
		索引条件下推（ Index Condition Pushdown，简称ICP）的功能，也就是把查询中与被使用索引有关的查询条件下推到存储引擎中判断，而不是返回到server层再判断
		索引条件下推只是为了减少回表次数，也就是减少读取完整的聚簇索引记录的次数，从而减少IO操作。
		对于聚簇索引而言不需要回表，它本身就包含着全部的列，也起不到减少IO操作的作用，所以设计InnoDB的大叔们规定这个索引条件下推特性只适用于二级索引。
		索引下推只能用于二级索引, 并且是针对select查询有效.
		
	2. 针对主键索引的范围等值查询, 需要访问到不满足条件的第一个值为止, 会把不满足条件的第一个值的锁释放掉.
	
	3. 针对update/delete模式的二级索引范围等值查询
	
		需要访问到不满足条件的第一个值为止, 但是会把不满足条件的第一个值+对应的主键索引的锁释放
		 
		
	4. 针对for update/lock in share mode模式的二级索引范围等值查询,需要访问到不满足条件的第一个值为止, 不满足条件的第一个值对应的主键索引不需要上锁, 并且对不满足条件的第一个值加锁, 
		-- 实际的update语句模式的二级索引范围等值查询,需要访问到不满足条件的第一个值为止, 不满足条件的第一个值对应的主键索引需要上锁, 并且对不满足条件的第一个值加锁。
		
	
    5. 普通索引的范围等值查询, 需要访问到不满足条件的第一个值为止, 并且需要加锁, 不会立即把该锁释放掉.
	
		类似于RR隔离级别下的唯一索引范围bug
				
		如果是更新语句(update/delete), 需要回到主键索引上进行加锁.
				
		参考笔记: 
			本案例的 "4. 二级索引等值范围锁" 
			投稿文章 https://mp.weixin.qq.com/s/oWXr68fBfWJcxKLL4V_IUw  一次死锁的过程分析
			"如果 session B 是更新语句, 那就不一样了"
				
			如果是主键索引的范围等值查询,也是需要访问到不满足条件的第一个值为止, 并且需要加锁, 判断该记录不符合等值条件，又要释放掉这条记录的锁. 
				参考笔记 <2020-05-27-证明RC隔离级别下先加锁再退化释放锁的实验.sql>
			
		
		
	虽然做总结会比较耗时一点, 但是为了掌握得更好和复习, 必须要做总结的.

	
	

7. 证明RC隔离级别下先加锁再退化释放锁的实验

7.1 表结构和数据的初始
	drop table if exists t1;
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

	mysql> select * from t1;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  3 |    3 |    3 |
	|  5 |    5 |    5 |
	+----+------+------+
	3 rows in set (0.00 sec)

	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.00 sec)

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.17    |
	+-----------+
	1 row in set (0.00 sec)
	
7.2 实验1
	
	session A      session B
	begin;      
	delete from t1 where id<=1; 
	
	
				   begin;
				   insert into t1 values(2,2,2);
				   (Query OK)
				   
				   delete from t1 where id=3;
				   (Query OK)
				   
	
7.3 实验2
	
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
								(Blocked)
	
	session B 的加锁过程之一: 

		因为这里是范围等值查询, 需要访问到 id=3 才会停止下来, 所以需要申请 id=3 的记录加锁, 因此被 session A 阻塞.

		假设没有 session A 这个事务, 并且 id=3 在RC级别下没有别的事务锁住，所以 session B 会把 id=3 的记录锁释放.
		
		如果对不满足条件的行上的行锁加锁的时候, 如果该行锁已经被别的事务持有, 那么就会被阻塞.
		
		也就是说找到的记录都会加锁，不符合加锁规则的就释放掉.
		
	
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



7.4 小结
	
	读提交隔离级别下还有一个优化，即：语句执行过程中加上的行锁，在语句执行完成后，就要把 不满足条件的行 上的行锁直接释放了，不需要等到事务提交。  
	
	
7.5 思考
	RR隔离级别怎么验证先加锁再退化释放锁
	
	
	

8. 证明RC隔离级别下先加锁再退化释放锁的实验 --基于主键索引范围等值查询
				

8.1 初始化表结构和数据 
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
	
	
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('2', '2', '2');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('3', '3', '3');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('4', '4', '4');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('5', '5', '5');
	
	root@mysqldb 13:32:  [sbtest]> select * from t;
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
		
	select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.12    |
	+-----------+
	1 row in set (0.07 sec)

	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.00 sec)

8.2 实验1

	ALTER table t auto_increment=6;
	session A           session B

	begin;	            
	mysql> INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');  							
	Query OK, 1 row affected (0.00 sec)
	
	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	|  6 |    6 |    6 |
	+----+------+------+
	6 rows in set (0.00 sec)
	T1时刻
						begin;  
						mysql> SELECT `id`, `c`, `d` from t WHERE ((`id` >= '4')) AND ((`id` <= '5')) LOCK IN SHARE MODE;	 
						(Blocked)
	T2时刻
		
		
	T1时刻
	
		root@mysqldb 19:12:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		| ENGINE_LOCK_ID | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
		+----------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		| 1594:1059      |                  1594 |        65 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL      |
		+----------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		1 row in set (0.00 sec)
		
		
	T2时刻	
	
		---TRANSACTION 1594, ACTIVE 446 sec
		2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
		MySQL thread id 17, OS thread handle 140146535069440, query id 94 localhost root
		TABLE LOCK table `sbtest`.`t` trx id 1594 lock mode IX
		RECORD LOCKS space id 2 page no 4 n bits 80 index PRIMARY of table `sbtest`.`t` trx id 1594 lock_mode X locks rec but not gap
		Record lock, heap no 7 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 8000000000000006; asc         ;;
		 1: len 6; hex 00000000063a; asc      :;;
		 2: len 7; hex 810000008b0110; asc        ;;
		 3: len 4; hex 80000006; asc     ;;
		 4: len 4; hex 80000006; asc     ;;

		
		root@mysqldb 19:34:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		| ENGINE_LOCK_ID        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
		+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		| 1594:1059             |                  1594 |        65 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL      |
		
		| 1594:2:4:7            |                  1594 |        66 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 6         |
		
		| 421624251677432:1059  |       421624251677432 |        66 | t           | NULL       | TABLE     | IS        | GRANTED     | NULL      |
		| 421624251677432:2:4:5 |       421624251677432 |        66 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 4         |
		| 421624251677432:2:4:6 |       421624251677432 |        66 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 5         |
		
		| 421624251677432:2:4:7 |       421624251677432 |        66 | t           | PRIMARY    | RECORD    | S         | WAITING     | 6         |
		+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		6 rows in set (0.00 sec)
	
		thread_id看起来也很奇怪。
		
			session A 持有 id=6 的行锁
			session B 是当前读，想持有 id=6 的行锁，处于等待状态中
			
		mysql> select * from performance_schema.data_lock_waits;
		+--------+---------------------------+----------------------------------+----------------------+---------------------+----------------------------------+-------------------------+--------------------------------+--------------------+-------------------+--------------------------------+
		| ENGINE | REQUESTING_ENGINE_LOCK_ID | REQUESTING_ENGINE_TRANSACTION_ID | REQUESTING_THREAD_ID | REQUESTING_EVENT_ID | REQUESTING_OBJECT_INSTANCE_BEGIN | BLOCKING_ENGINE_LOCK_ID | BLOCKING_ENGINE_TRANSACTION_ID | BLOCKING_THREAD_ID | BLOCKING_EVENT_ID | BLOCKING_OBJECT_INSTANCE_BEGIN |
		+--------+---------------------------+----------------------------------+----------------------+---------------------+----------------------------------+-------------------------+--------------------------------+--------------------+-------------------+--------------------------------+
		| INNODB | 421624251677432:2:4:7     |                  421624251677432 |                   66 |                   8 |                  140149279202752 | 1594:2:4:7              |                           1594 |                 66 |                 4 |                140149279196456 |
		+--------+---------------------------+----------------------------------+----------------------+---------------------+----------------------------------+-------------------------+--------------------------------+--------------------+-------------------+--------------------------------+


	
	session B先执行， session A不会被阻塞，如下所示
	
		session A           session B
		begin;				
		SELECT `id`, `c`, `d` from t WHERE ((`id` >= '4')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		|  4 |    4 |    4 |
		|  5 |    5 |    5 |
		+----+------+------+
		2 rows in set (0.00 sec)
		
							begin;
							insert into t(c,d) values(6,6);
							(Query OK)
							1 row in set (0.00 sec)	
							
							mysql> select * from t;
							+----+------+------+
							| id | c    | d    |
							+----+------+------+
							|  1 |    1 |    1 |
							|  2 |    2 |    2 |
							|  3 |    3 |    3 |
							|  4 |    4 |    4 |
							|  5 |    5 |    5 |
							|  6 |    6 |    6 |
							+----+------+------+
							6 rows in set (0.00 sec)

		
		session A 持有的锁
			root@mysqldb 22:05:  [sbtest]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
			| ENGINE_LOCK_ID        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
			+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
			| 421624251676512:1059  |       421624251676512 |        69 | t           | NULL       | TABLE     | IS        | GRANTED     | NULL      |
			| 421624251676512:2:4:5 |       421624251676512 |        69 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 4         |
			| 421624251676512:2:4:6 |       421624251676512 |        69 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 5         |
			+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
			3 rows in set (0.10 sec)
		
8.3  实验2		
			
	session A           session B

	begin;	         
	SELECT `id`, `c`, `d` from t WHERE ((`id` >= '4')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	2 rows in set (0.03 sec)

	T1
						begin;
						INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');  							
						Query OK, 1 row affected (0.00 sec)
											  
										
	root@mysqldb 15:13:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	| ENGINE_LOCK_ID        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
	+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	| 421624251676512:1059  |       421624251676512 |        59 | t           | NULL       | TABLE     | IS        | GRANTED     | NULL      |
	| 421624251676512:2:4:5 |       421624251676512 |        59 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 4         |
	| 421624251676512:2:4:6 |       421624251676512 |        59 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 5         |
	+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	3 rows in set (0.01 sec)




9.1 初始化表结构和数据
	CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB;
	insert into t values(0,0,0),(5,5,5),(10,10,10),(15,15,15),(20,20,20),(25,25,25);

	mysql>select * from t;
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

9.2 环境 
	mysql>select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.19-log |
	+------------+
	1 row in set (0.00 sec)

	mysql>show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.01 sec)

	mysql>show global variables like '%isolation%';

	+---------------+----------------+
	| Variable_name | Value          |
	+---------------+----------------+
	| tx_isolation  | READ-COMMITTED |
	+---------------+----------------+
	1 row in set (0.00 sec)

	mysql>select @@session.tx_isolation;
	+------------------------+
	| @@session.tx_isolation |
	+------------------------+
	| READ-COMMITTED         |
	+------------------------+
	1 row in set (0.00 sec)

9.3 实验1

	session A                              session B                                                                                                                                                                                                            
	begin;
	select * from t where id>10 and id<=15 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 15 |   15 |   15 |
	+----+------+------+
	1 row in set (0.00 sec)

											update t set d=d+1 where id=20;
											Query OK, 1 row affected (0.00 sec)
											Rows matched: 1  Changed: 1  Warnings: 0 
	
		
	
9.4 实验2

	session A                            	session B                                                                                                                                                                                                            
	begin;
	update t set d=d+1 where id=20;
	Query OK, 1 row affected (0.00 sec)
	Rows matched: 1  Changed: 1  Warnings: 0

											begin;
											select * from t where id>10 and id<=15 for update;
											(Blocked)
	
	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 5244497
					 trx_state: LOCK WAIT
				   trx_started: 2020-09-18 14:36:58
		 trx_requested_lock_id: 5244497:2068:3:6
			  trx_wait_started: 2020-09-18 14:36:58
					trx_weight: 3
		   trx_mysql_thread_id: 34012
					 trx_query: select * from t where id>10 and id<=15 for update
		   trx_operation_state: fetching rows
			 trx_tables_in_use: 1
			 trx_tables_locked: 1
			  trx_lock_structs: 3
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 2
			 trx_rows_modified: 0
	   trx_concurrency_tickets: 0
		   trx_isolation_level: READ COMMITTED
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	*************************** 2. row ***************************
						trx_id: 5244494
					 trx_state: RUNNING
				   trx_started: 2020-09-18 14:33:20
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 34011
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 1
			  trx_lock_structs: 2
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 1
			 trx_rows_modified: 1
	   trx_concurrency_tickets: 0
		   trx_isolation_level: READ COMMITTED
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	2 rows in set (0.00 sec)
		
	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 5244497:2068:3:6
	lock_trx_id: 5244497
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `base_db`.`t`
	 lock_index: PRIMARY
	 lock_space: 2068
	  lock_page: 3
	   lock_rec: 6
	  lock_data: 20
	*************************** 2. row ***************************
		lock_id: 5244494:2068:3:6
	lock_trx_id: 5244494
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `base_db`.`t`
	 lock_index: PRIMARY
	 lock_space: 2068
	  lock_page: 3
	   lock_rec: 6
	  lock_data: 20
	2 rows in set, 1 warning (0.00 sec)

	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 5244497
	requested_lock_id: 5244497:2068:3:6
	  blocking_trx_id: 5244494
	 blocking_lock_id: 5244494:2068:3:6
	1 row in set, 1 warning (0.00 sec)


	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+---------------------------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                                     | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+---------------------------------------------------+-------------------+--------------------+
	| PRIMARY      | RECORD      | select * from t where id>10 and id<=15 for update | X                 | X                  |
	+--------------+-------------+---------------------------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.03 sec)


											
9.5 实验3

	session A                               session B                                                                                                                                                                                                            
	begin;
	update t set d=d+1 where id=20;
	Query OK, 1 row affected (0.00 sec)
	Rows matched: 1  Changed: 1  Warnings: 0
											
											begin;
											update t set d=d+1 where id>10 and id<=15;
											Query OK, 1 row affected (0.00 sec)
											Rows matched: 1  Changed: 1  Warnings: 0


										
9.6 小结
	存在，先加锁后释放锁。
	下面的3个实验也有提到：
		2020-05-17-验证8.0.19版本主键索引是否存在锁升级即唯一索引bug.sql
		2020-05-24-验证8.0.18版本是否存在主键记录锁扩大即唯一索引bug的优化.sql
		2020-05-25-验证8.0.17版本RR隔离级别没有优化唯一索引的bug.sql
		
		
		
	
	
10.1 初始表结构和数据初始化	CREATE TABLE `t` (
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
	
10.2 现象和我的问题
	
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
		
		理解了，参考笔记 《2020-05-27-证明RC隔离级别下先加锁再退化释放锁的实验.sql》
		
	姜少华的解答
		1.insert的通过自增加的隐式锁       
		2.第二个语句是锁的过程实际上是id<=5的下一条记录也就是这个页的最大记录（如果这个在RC级别下没有被锁，则会立即释放）
		举个例子  id 1，3，5   
		在RC级别下 select * from table where id<=3 实际上加锁的过程是1 3 5(这个随后释放掉)   最终加锁1 3


10.3 MySQL 8.0.17版本
	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.17    |
	+-----------+
	1 row in set (0.00 sec)
	
10.3.1 事务隔离级别为RC读已提交
	
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
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)

	session A 持有 id=6 的行锁
	session B 是当前读，想持有 id=6 的行锁，处于等待状态中。
			
10.4 MySQL 8.0.18版本

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)
	
10.4.1 事务隔离级别为RC读已提交

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
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)
	
	session A 持有 id=6 的行锁
	session B 是当前读，想持有 id=6 的行锁，处于等待状态中。
	
	