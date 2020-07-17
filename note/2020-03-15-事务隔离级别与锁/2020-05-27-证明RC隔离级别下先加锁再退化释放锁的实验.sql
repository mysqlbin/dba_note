
1. 表结构和数据的初始
2. 实验1
3. 实验2
4. 小结
5. 思考


1. 表结构和数据的初始
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
	
2. 实验1
	
	session A      session B
	begin;      
	delete from t1 where id<=1; 
	
	
				   begin;
				   insert into t1 values(2,2,2);
				   (Query OK)
				   
				   delete from t1 where id=3;
				   (Query OK)
				   
	
3. 实验2
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
		
		如果对不满足条件的行上的行锁加锁的时候, 如果该行锁已经被别的事务持有,那么就会被阻塞.
		
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



4. 小结
	
	读提交隔离级别下还有一个优化，即：语句执行过程中加上的行锁，在语句执行完成后，就要把 不满足条件的行 上的行锁直接释放了，不需要等到事务提交。  
	
	
5. 思考
	RR隔离级别怎么验证先加锁再退化释放锁
	
	
	
