
https://mp.weixin.qq.com/s/KL-xVv8asA78bH9bVQLwPw  MySQL锁都分不清，怎么面试进大厂？
	
	
表锁(lock tables)

只有正确通过索引条件检索数据（没有索引失效的情况），InnoDB才会使用行级锁，否则InnoDB对表中的所有记录加锁，也就是将锁住整个表。 是否可以读、插入数据？需要验证下。

这里说的是锁住整个表，但是InnoDB并不是使用表锁来锁住表的，而是使用了下面介绍的Next-Key Lock来锁住整个表。



表级锁

表锁


表锁和表级锁
	表锁: lock table t write/read; 
	表级锁: 
		MDL锁、自增锁、意向锁
		锁住全表的记录
		
	

CREATE TABLE `t` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

root@mysqldb 17:52:  [zst]> select * from t;
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


root@mysqldb 17:52:  [zst]> select version();
+-----------+
| version() |
+-----------+
| 8.0.18    |
+-----------+
1 row in set (0.00 sec)

	
隔离级别为 RR

	SESSION A
	begin;
	SELECT * FROM t lock in share mode;
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

	

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA              |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
	| 139811159241888:1338:139811050567864    |       421286135952544 |       167 | t           | NULL       | TABLE     | IS        | GRANTED     | NULL                   |
	| 139811159241888:281:4:1:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S         | GRANTED     | supremum pseudo-record |
	| 139811159241888:281:4:2:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 1                      |
	| 139811159241888:281:4:3:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 2                      |
	| 139811159241888:281:4:4:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 3                      |
	| 139811159241888:281:4:5:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 4                      |
	| 139811159241888:281:4:6:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 5                      |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
	7 rows in set (0.00 sec)
	
	supremum pseudo-record：它是索引中的伪记录(pseudo-record)，代表此索引中可能存在的最大值
	
	锁住了(-∞,1],(1,2],(2,3],(3,4],(4,5],(5,∞]，



隔离级别为 RC	
	
	root@mysqldb 17:52:  [zst]> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)
	
	SESSION A
	begin;
	SELECT * FROM t lock in share mode;
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

	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140570760526704:1338:140570655811576    |       422045737237360 |        58 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140570760526704:281:4:2:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 140570760526704:281:4:3:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 140570760526704:281:4:4:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140570760526704:281:4:5:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 140570760526704:281:4:6:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 5         |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	6 rows in set (0.03 sec)
	
	锁住了[1],[2],[3],[4],[5]，没有间隙锁。
	
	
	
	