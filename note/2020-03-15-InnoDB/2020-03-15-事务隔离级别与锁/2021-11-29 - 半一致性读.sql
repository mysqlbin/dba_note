

半一致性读(semi-consistent read)



mysql> show global variables like '%iso%';
+-----------------------+----------------+
| Variable_name         | Value          |
+-----------------------+----------------+
| transaction_isolation | READ-COMMITTED |
+-----------------------+----------------+
1 row in set (0.00 sec)


mysql> select version();
+-----------+
| version() |
+-----------+
| 8.0.18    |
+-----------+
1 row in set (0.00 sec)




CREATE TABLE hero (
    number INT,
    name VARCHAR(100),
    country varchar(100),
    PRIMARY KEY (number),
    KEY idx_name (name)
) Engine=InnoDB CHARSET=utf8;

INSERT INTO hero VALUES
    (1, 'l刘备', '蜀'),
    (3, 'z诸葛亮', '蜀'),
    (8, 'c曹操', '魏'),
    (15, 'x荀彧', '魏'),
    (20, 's孙权', '吴');
	
	
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
5 rows in set (0.00 sec)




mysql> EXPLAIN SELECT * FROM hero WHERE country = '魏' FOR UPDATE;
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | hero  | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    5 |    20.00 | Using where |
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


begin;

SELECT * FROM hero WHERE country = '魏' FOR UPDATE;
	
	
mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
| 140411062360680:1099:140410936685224   |               4814873 |        59 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL      |
| 140411062360680:42:4:4:140410936682184 |               4814873 |        59 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 8         |
| 140411062360680:42:4:5:140410936682184 |               4814873 |        59 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 15        |
+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
3 rows in set (0.02 sec)
	
	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	
	
session A                               session B		
begin;									begin;

SELECT * FROM hero WHERE country = '魏' FOR UPDATE;
	
										SELECT * FROM hero WHERE country = '吴' FOR UPDATE;
										(Blocked)
										
mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
| 140411062361552:1099:140410936691176   |               4814874 |        58 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL      |

被number=8的主键索引记录锁阻塞
| 140411062361552:42:4:4:140410936688592 |               4814874 |        58 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 8         |

| 140411062360680:1099:140410936685224   |               4814873 |        59 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL      |
| 140411062360680:42:4:4:140410936682184 |               4814873 |        59 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 8         |
| 140411062360680:42:4:5:140410936682184 |               4814873 |        59 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 15        |
+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
5 rows in set (0.00 sec)


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

session A                              session B	
begin;									begin;

SELECT * FROM hero WHERE country = '魏' FOR UPDATE;
	
										UPDATE hero SET name = 'xxx' WHERE country = '吴';
										(Query Ok)
			
										mysql> select * from hero where country = '吴';
										+--------+------+---------+
										| number | name | country |
										+--------+------+---------+
										|     20 | xxx  | 吴      |
										+--------+------+---------+
										1 row in set (0.00 sec)



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

分析：
		
	当UPDATE语句读取已经被其他事务加了锁的记录时，InnoDB会将该记录的最新版本读出来，然后判断该版本是否与UPDATE语句中的WHERE条件相匹配，如果不匹配则不对该记录加锁，从而跳到下一条记录；如果匹配则再次读取该记录并对其进行加锁。
	这样子处理只是为了让UPDATE语句尽量少被别的语句阻塞。

	因为事务 session B  执行UPDATE语句时使用了半一致性读，判断number列值为8和15这两条记录的最新版本的country列值均不为UPDATE语句中WHERE条件中的'吴'，所以直接就跳过它们，不对它们加锁了。
		
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
		5 rows in set (0.00 sec)
			
	
	
小结：
	
	是一种用在 Update 语句中的读操作（一致性读）的优化，是在 RC 事务隔离级别下与一致性读的结合。

	半一致性读只适用于对聚簇索引记录更新加锁的情况，并不适用于对二级索引记录加锁的情况。
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	在 RC 事务隔离级别下，Update 语句可以利用到半一致性读的特性，会多进行一次判断，
	当 where 条件匹配到的记录与当前持有锁的事务中的记录不冲突时，就会提前释放 InnoDB 锁，虽然这样做违背了二阶段加锁协议，但却可以减少锁冲突，提高事务并发能力，是一种很好的优化行为。
		-- 描述得不对。
	当 where 条件匹配到的记录与当前持有锁的事务中的记录不冲突时，那么就不需要申请对记录加锁。
	
	

相关参考：
	
	https://mp.weixin.qq.com/s/PfT5--Q1EQPpn-9uKABzfQ
	
	https://zhuanlan.zhihu.com/p/36682577

	



