
1. 表结构和数据的初始化
2. 主键索引范围锁
3. 二级索引等值锁
4. 二级索引等值范围锁
	4.1 实验1
	4.2 实验2

6. 小结

	
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


	root@mysqldb 17:36:  [(none)]> select @@session.transaction_isolation;
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
				参考笔记 <2020-05-27-证明RC隔离级别下先加锁再退化释放锁的实验.sql>
			
		
		会为name值为'c曹操'和'l刘备'的二级索引记录以及'c曹操'对应的聚簇索引进行加锁
		
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
				session A           session B		
				begin;
				SELECT * FROM hero FORCE INDEX(idx_name) WHERE name <= 'c曹操' for update;
				+--------+---------+---------+
				| number | name    | country |
				+--------+---------+---------+
				|      8 | c曹操   | 魏      |
				+--------+---------+---------+
				1 row in set (0.01 sec)
			
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
								desc SELECT * FROM hero FORCE INDEX(idx_name) WHERE name <= 'c曹操' for update;
								+--------+---------+---------+
								| number | name    | country |
								+--------+---------+---------+
								|      8 | c曹操   | 魏      |
								+--------+---------+---------+
								1 row in set (0.00 sec)	
								
				
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
							update hero set name = '曹操' where name <= 'c曹操';
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
	
	验证是否会锁住不满足条件的第一个值
		session A            session B
		begin;
		UPDATE hero SET country = '汉' WHERE name <= 'c曹操';
							
							 BEGIN;
							 delete from hero where name='l刘备';
							 (Query OK)
					
	验证是否会锁住不满足条件的第一个值对应的主键值
		session A 
		begin;
		delete from hero where number=1;
							begin;
							UPDATE hero SET country = '汉' WHERE name <= 'c曹操';
							(Blocked)
		
		root@mysqldb 22:52:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
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
	
	下面的例子验证了读提交隔离级别下还有一个优化，即：语句执行过程中加上的行锁，在语句执行完成后，就要把 不满足条件的行 上的行锁直接释放了，不需要等到事务提交。  
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
		 
		
	4. 针对for update/lock in share mode模式的二级索引范围等值查询,需要访问到不满足条件的第一个值为止, 对应的主键索引不需要上锁, 并且对不满足条件的第一个值加锁, 
		
	
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

	
	
	
	