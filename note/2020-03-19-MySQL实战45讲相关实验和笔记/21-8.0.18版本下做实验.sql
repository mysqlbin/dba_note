
1. 意向锁 
2. 加锁规则		
3. 环境	 
4.1.1 唯一索引等值查询间隙锁
4.1.2 主键索引范围锁																								
4.1.3 优化了唯一索引范围 bug 
4.1.4 唯一索引范围非等值查询&order by

4.2.1 非唯一索引等值锁--lock in share mode模式
4.2.1 非唯一索引等值锁--for update模式
4.2.2 非唯一索引范围锁
4.2.3 非唯一索引上等值查询
4.2.5 非唯一索引上等值查询-Gap lock死锁 
4.2.6 非唯一索引范围等值查询--order by desc --这个例子不好理解
4.2.6 非唯一索引范围等值查询--没有order by desc
4.2.7 非唯一索引in等值查询的加锁过程
4.2.8 非唯一索引in等值查询&order by的加锁过程


1. 意向锁 
  InnoDB特有，加载在表级别上的锁。
   意向锁是什么： 是加载在数据表B+树结构的根节点， 也就是对整个表加意向锁。
   意向锁的作用： 避免在执行DML时，对表执行DDL操作，导致数据不一致。
   InnoDB存储引擎支持两种意向锁：
	1） 意向共享锁（IS Lock）: 当前事务想要获取一张表中某几行的共享锁
	2） 意向排他锁（IX Lock）: 当前事务想要获得一张表中某几行的排他锁
	由于 InnoDB 存储引擎支持的是行级别的锁， 因此意向锁其实不会阻塞除全表扫描以外的任何请求。
   # 这里可能通过例子来验证。
   
2. 加锁规则		
	两个原则：
	 a). 原则 1：加锁的基本单位是 next-key lock。
					 next-key lock 是前开后闭区间（5, 10]。
	 b). 原则 2：普通索引查找，要向右遍历, 遍历过程中被访问到的对象才会加锁。
				 范围查询, 也需要向右遍历
				 
	索引上等值查询的两个优化：
	 c). 优化 1：索引上的等值查询, 给唯一索引加锁的时候，next-key lock退化为行锁。
	 d). 优化 2：索引上的等值查询, 向右遍历时且如果最后一个值不满足等值条件的时候，next-key lock 会退化为间隙锁。
	 
	bug：
	 e). 一个 bug：唯一索引上的范围查询，会访问到不满足条件的第一个值为止。

3. 环境	 
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

select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;

4.1.1 唯一索引等值查询间隙锁
CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB;
insert into t values(0,0,0),(5,5,5),(10,10,10),(15,15,15),(20,20,20),(25,25,25);


session A                                        session B                                       session C
 begin;
 update t set d=d+1 where id=7;
                                                        insert into t values(6,6,6); 
                                                        (Blocked)
																								 T1: select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
																								 
														insert into t values(4,4,4);
														(Query OK)
														
                                                        insert into t values(8,8,8); 
                                                        (Blocked)
																								update t set d=d+1 where id=10;
																								(Query OK)
																								
T1:
	root@mysqldb 22:17:  [(none)]>  select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| 139859108163288:1303:139859033423736    |                869510 |      1983 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139859108163288:246:4:4:139859033420744 |                869510 |      1983 | t           | PRIMARY    | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 10        |

	| 139859108162416:1303:139859033417720    |                869508 |      1988 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139859108162416:246:4:4:139859033414776 |                869508 |      1988 | t           | PRIMARY    | RECORD    | X,GAP                  | GRANTED     | 10        |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	4 rows in set (0.00 sec)

	root@mysqldb 22:18:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| locked_index | locked_type | waiting_query               | waiting_lock_mode      | blocking_lock_mode |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| PRIMARY      | RECORD      | insert into t values(6,6,6) | X,GAP,INSERT_INTENTION | X,GAP              |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	1 row in set (0.01 sec)

	
4.1.2 主键索引范围锁																								
session A                                  session B                session C                     session D                                                                                                   
begin;
select * from t where id>=10 and id<11 for update;
+----+------+------+
| id | c    | d    |
+----+------+------+
| 10 |   10 |   10 |
+----+------+------+
1 row in set (0.14 sec)
T1: performance_schema.data_locks
											insert into t values(8,8,8);
											(Query OK)
											insert into t values(11,11,11);
											(Blocked)
											
											T2
																	update t set d=d+1 where id=10;
																	(Blocked)
																																																																										update t set d=d+1 where id=15;
																								 update t set d=d+1 where id=15;
																								 (Query OK)																																																							(Query OK)
																																																																										
T1																																																	T1:																								
root@mysqldb 22:37:  [(none)]>  select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
| 139859108158928:1303:139859033393640    |                869525 |      1990 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
| 139859108158928:246:4:4:139859033390712 |                869525 |      1990 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 10        |
| 139859108158928:246:4:5:139859033391056 |                869525 |      1990 | t           | PRIMARY    | RECORD    | X,GAP         | GRANTED     | 15        |
+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
3 rows in set (0.00 sec)

T2																																																		
	root@mysqldb 22:37:  [(none)]>  select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| 139859108163288:1303:139859033423736    |                869533 |      1983 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139859108163288:246:4:5:139859033420744 |                869533 |      1983 | t           | PRIMARY    | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 15        |
	
	| 139859108158928:1303:139859033393640    |                869525 |      1990 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139859108158928:246:4:4:139859033390712 |                869525 |      1990 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP          | GRANTED     | 10        |
	| 139859108158928:246:4:5:139859033391056 |                869525 |      1990 | t           | PRIMARY    | RECORD    | X,GAP                  | GRANTED     | 15        |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	5 rows in set (0.01 sec)

	root@mysqldb 22:37:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+--------------------------------+------------------------+--------------------+
	| locked_index | locked_type | waiting_query                  | waiting_lock_mode      | blocking_lock_mode |
	+--------------+-------------+--------------------------------+------------------------+--------------------+
	| PRIMARY      | RECORD      | insert into t values(11,11,11) | X,GAP,INSERT_INTENTION | X,GAP              |
	+--------------+-------------+--------------------------------+------------------------+--------------------+
	1 row in set (0.06 sec)
											

4.1.3 优化了唯一索引范围 bug 
优化了尾点延伸  
其它相关参考： https://mp.weixin.qq.com/s/xDKKuIvVgFNiKp5kt2NIgA  
session A                                       session B                                                                                                                                                                                     
begin;
select * from t where id>10 and id<=15 for update;
+----+------+------+
| id | c    | d    |
+----+------+------+
| 15 |   15 |   15 |
+----+------+------+
1 row in set (0.00 sec)
T1: performance_schema.data_locks
												begin;
												update t set d=d+1 where id=20;
												(Query OK)  
												
												insert into t values(12,12,12); 
												(Blocked)
T2	
												insert into t values(16,16,16); 
												(Query OK)
T3		

T1
mysql>  select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
| 139859108158928:1303:139859033393640    |                869538 |      1996 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL      |
| 139859108158928:246:4:5:139859033390712 |                869538 |      1996 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 15        |
+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
2 rows in set (0.00 sec)

T2
mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
| 140538819522000:1074:140538711967992   |                  2474 |       111 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
| 140538819522000:17:4:5:140538711965064 |                  2474 |       111 | t           | PRIMARY    | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 15        |
| 140538819521128:1074:140538711962040   |                  2473 |       110 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
| 140538819521128:17:4:5:140538711959000 |                  2473 |       110 | t           | PRIMARY    | RECORD    | X                      | GRANTED     | 15        |
+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
4 rows in set (0.00 sec)
												
4.1.4 唯一索引范围非等值查询&order by

	session A
	begin;
	select * from t where id>9 and id<12 order by id desc for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 10 |   10 |   10 |
	+----+------+------+
	1 row in set (0.00 sec)
		
	mysql>  select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	| 139859108161544:1303:139859033411576    |                869547 |      1997 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL      |
	| 139859108161544:246:4:5:139859033408536 |                869547 |      1997 | t           | PRIMARY    | RECORD    | X,GAP     | GRANTED     | 15        |
	| 139859108161544:246:4:3:139859033408880 |                869547 |      1997 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 5         |
	| 139859108161544:246:4:4:139859033408880 |                869547 |      1997 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 10        |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	4 rows in set (0.00 sec)

	加锁范围: primary: gap lock: (10,15) + primary: next-key lock: (5,10] + primary: next-key lock: (0,5]
	
4.2.1 非唯一索引等值锁--lock in share mode模式
         覆盖索引，因为不需要访问主键索引，所以不对主键索引加锁    

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

 session A                                        session B                                       session C                             session D
 begin;
 select id from t where c=5 lock in share mode;
 如果查询语句是 select id from t where c=5 lock in share mode; 呢？

                                                        update t set d=d+1 where id=5;
                                                        (Query OK)
																									insert into t values(7,7,7); 
																									(Blocked)
T1
																																			insert into t values(2,2,2);
																																			(Blocked)

T2

Session A 的加锁规则如下：c: Next-key Lock：(0, 5]  + c: GAP Lock: (5, 10)

T1
	root@mysqldb 10:25:  [(none)]>  select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| 139859108159800:1303:139859033399624    |                869548 |      2003 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139859108159800:246:5:4:139859033396744 |                869548 |      2003 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 10, 10    |

	| 139859108158928:1303:139859033393640    |       421334084869584 |      2002 | t           | NULL       | TABLE     | IS                     | GRANTED     | NULL      |
	| 139859108158928:246:5:3:139859033390712 |       421334084869584 |      2002 | t           | c          | RECORD    | S                      | GRANTED     | 5, 5      |
	| 139859108158928:246:5:4:139859033391056 |       421334084869584 |      2002 | t           | c          | RECORD    | S,GAP                  | GRANTED     | 10, 10    |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	5 rows in set (0.00 sec)

	root@mysqldb 10:25:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| locked_index | locked_type | waiting_query               | waiting_lock_mode      | blocking_lock_mode |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| c            | RECORD      | insert into t values(7,7,7) | X,GAP,INSERT_INTENTION | S,GAP              |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	1 row in set (0.03 sec)

T2
	root@mysqldb 10:25:  [(none)]>  select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| 139859108159800:1303:139859033399624    |                869549 |      2003 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139859108159800:246:5:3:139859033396744 |                869549 |      2003 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 5, 5      |

	| 139859108158928:1303:139859033393640    |       421334084869584 |      2002 | t           | NULL       | TABLE     | IS                     | GRANTED     | NULL      |
	| 139859108158928:246:5:3:139859033390712 |       421334084869584 |      2002 | t           | c          | RECORD    | S                      | GRANTED     | 5, 5      |
	| 139859108158928:246:5:4:139859033391056 |       421334084869584 |      2002 | t           | c          | RECORD    | S,GAP                  | GRANTED     | 10, 10    |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	5 rows in set (0.00 sec)

	root@mysqldb 10:26:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| locked_index | locked_type | waiting_query               | waiting_lock_mode      | blocking_lock_mode |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| c            | RECORD      | insert into t values(2,2,2) | X,GAP,INSERT_INTENTION | S                  |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	1 row in set (0.00 sec)

4.1.4 唯一索引范围非等值查询&order by
    begin;
    select * from t where id>9 and id<12 order by id desc for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 10 |   10 |   10 |
	+----+------+------+
	1 row in set (0.00 sec)
	

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	| 139811159239272:1303:139811050549928    |               1004475 |        95 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL      |
	| 139811159239272:246:4:5:139811050546888 |               1004475 |        95 | t           | PRIMARY    | RECORD    | X,GAP     | GRANTED     | 15        |
	| 139811159239272:246:4:3:139811050547232 |               1004475 |        95 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 5         |
	| 139811159239272:246:4:4:139811050547232 |               1004475 |        95 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 10        |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	4 rows in set (0.00 sec)

	


4.2.1 非唯一索引等值锁--for update模式
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

 session A                                        session B                                       session C                             session D
 begin;
 select id from t where c=5 for update;

                                                    update t set d=d+1 where id=5;
                                                    (Blocked)
T1
																								insert into t values(7,7,7); 
																								(Blocked)
T2
																																		insert into t values(2,2,2);
																																		(Blocked)

T3

在执行for update时，系统会认为你接下来要更新数据，因此会顺便给主键索引上满足条件的行加上行锁。

T1
	root@mysqldb 12:11:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139859108160672:1303:139859033405624    |                869628 |      2037 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |

	| 139859108160672:246:4:3:139859033402584 |                869628 |      2037 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 5         |

	| 139859108163288:1303:139859033423736    |                869627 |      2040 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139859108163288:246:5:3:139859033420744 |                869627 |      2040 | t           | c          | RECORD    | X             | GRANTED     | 5, 5      |

	| 139859108163288:246:4:3:139859033421088 |                869627 |      2040 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 5         |

	| 139859108163288:246:5:4:139859033421432 |                869627 |      2040 | t           | c          | RECORD    | X,GAP         | GRANTED     | 10, 10    |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	6 rows in set (0.01 sec)

	root@mysqldb 16:28:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                 | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+-------------------------------+-------------------+--------------------+
	| PRIMARY      | RECORD      | update t set d=d+1 where id=5 | X,REC_NOT_GAP     | X,REC_NOT_GAP      |
	+--------------+-------------+-------------------------------+-------------------+--------------------+
	1 row in set (0.03 sec)

	session B在等主键索引的锁.

T2
	root@mysqldb 16:28:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| 139859108160672:1303:139859033405624    |                869629 |      2037 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139859108160672:246:5:4:139859033402584 |                869629 |      2037 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 10, 10    |

	| 139859108163288:1303:139859033423736    |                869627 |      2040 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139859108163288:246:5:3:139859033420744 |                869627 |      2040 | t           | c          | RECORD    | X                      | GRANTED     | 5, 5      |
	| 139859108163288:246:4:3:139859033421088 |                869627 |      2040 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP          | GRANTED     | 5         |

	| 139859108163288:246:5:4:139859033421432 |                869627 |      2040 | t           | c          | RECORD    | X,GAP                  | GRANTED     | 10, 10    |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	6 rows in set (0.00 sec)

	root@mysqldb 16:29:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| locked_index | locked_type | waiting_query               | waiting_lock_mode      | blocking_lock_mode |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| c            | RECORD      | insert into t values(7,7,7) | X,GAP,INSERT_INTENTION | X,GAP              |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	1 row in set (0.01 sec)

T3
	root@mysqldb 16:29:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| 139859108160672:1303:139859033405624    |                869630 |      2037 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139859108160672:246:5:3:139859033402584 |                869630 |      2037 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 5, 5      |
	| 139859108163288:1303:139859033423736    |                869627 |      2040 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139859108163288:246:5:3:139859033420744 |                869627 |      2040 | t           | c          | RECORD    | X                      | GRANTED     | 5, 5      |
	| 139859108163288:246:4:3:139859033421088 |                869627 |      2040 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP          | GRANTED     | 5         |
	| 139859108163288:246:5:4:139859033421432 |                869627 |      2040 | t           | c          | RECORD    | X,GAP                  | GRANTED     | 10, 10    |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	6 rows in set (0.01 sec)

	root@mysqldb 16:29:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| locked_index | locked_type | waiting_query               | waiting_lock_mode      | blocking_lock_mode |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| c            | RECORD      | insert into t values(2,2,2) | X,GAP,INSERT_INTENTION | X                  |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	1 row in set (0.00 sec)


4.2.2 非唯一索引范围锁

session A  		session B 	    session C	                session D                 session E
begin;
select * from t where c>=10 and c<11 for update;			
				insert into t values(8,8,8);
				(Blocked)	
T1
								insert into t values(11,11,11); 
								(Blocked)	 
T2
														update t set d=d+1 where c=15;
														 (Blocked)
T3
																			          update t set d=d+1 where id=15;
																						(Query OK)


T1

	root@mysqldb 18:01:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| 139859108162416:1303:139859033417720    |                869657 |      2052 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139859108162416:246:5:4:139859033414776 |                869657 |      2052 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 10, 10    |

	| 139859108161544:1303:139859033411576    |                869655 |      2051 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139859108161544:246:5:4:139859033408536 |                869655 |      2051 | t           | c          | RECORD    | X                      | GRANTED     | 10, 10    |
	| 139859108161544:246:5:5:139859033408536 |                869655 |      2051 | t           | c          | RECORD    | X                      | GRANTED     | 15, 15    |
	| 139859108161544:246:4:4:139859033408880 |                869655 |      2051 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP          | GRANTED     | 10        |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	6 rows in set (0.00 sec)

	root@mysqldb 18:03:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| locked_index | locked_type | waiting_query               | waiting_lock_mode      | blocking_lock_mode |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| c            | RECORD      | insert into t values(8,8,8) | X,GAP,INSERT_INTENTION | X                  |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	1 row in set (0.00 sec)

T2
	root@mysqldb 18:03:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| 139859108162416:1303:139859033417720    |                869658 |      2052 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139859108162416:246:5:5:139859033414776 |                869658 |      2052 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 15, 15    |
	| 139859108161544:1303:139859033411576    |                869655 |      2051 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139859108161544:246:5:4:139859033408536 |                869655 |      2051 | t           | c          | RECORD    | X                      | GRANTED     | 10, 10    |
	| 139859108161544:246:5:5:139859033408536 |                869655 |      2051 | t           | c          | RECORD    | X                      | GRANTED     | 15, 15    |
	| 139859108161544:246:4:4:139859033408880 |                869655 |      2051 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP          | GRANTED     | 10        |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	6 rows in set (0.00 sec)

	root@mysqldb 18:04:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+--------------------------------+------------------------+--------------------+
	| locked_index | locked_type | waiting_query                  | waiting_lock_mode      | blocking_lock_mode |
	+--------------+-------------+--------------------------------+------------------------+--------------------+
	| c            | RECORD      | insert into t values(11,11,11) | X,GAP,INSERT_INTENTION | X                  |
	+--------------+-------------+--------------------------------+------------------------+--------------------+
	1 row in set (0.01 sec)




T3
	root@mysqldb 18:01:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139859108162416:1303:139859033417720    |                869656 |      2052 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139859108162416:246:5:5:139859033414776 |                869656 |      2052 | t           | c          | RECORD    | X             | WAITING     | 15, 15    |
	| 139859108161544:1303:139859033411576    |                869655 |      2051 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139859108161544:246:5:4:139859033408536 |                869655 |      2051 | t           | c          | RECORD    | X             | GRANTED     | 10, 10    |
	| 139859108161544:246:5:5:139859033408536 |                869655 |      2051 | t           | c          | RECORD    | X             | GRANTED     | 15, 15    |
	| 139859108161544:246:4:4:139859033408880 |                869655 |      2051 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 10        |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	6 rows in set (0.00 sec)

	root@mysqldb 17:09:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                 | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+-------------------------------+-------------------+--------------------+
	| c            | RECORD      | update t set d=d+1 where c=15 | X                 | X                  |
	+--------------+-------------+-------------------------------+-------------------+--------------------+
	1 row in set (0.01 sec)

	-- 生产环境有遇到过这样的案例.




4.2.3 非唯一索引上等值查询

insert into t values(30,10,30);
mysql> select c,id from t order by c asc;
+------+----+
| c    | id |
+------+----+
|    0 |  0 |
|    5 |  5 |
|   10 | 10 |
|   10 | 30 |
|   15 | 15 |
|   20 | 20 |
|   25 | 25 |
+------+----+
7 rows in set (0.00 sec)



session A                           session B                          session C                        session D
begin;
delete from t where c=10; 
									insert into t values(12,12,12);
									(Blocked)
									
T1									
																		update t set d=d+1 where c=15;
																		(Query OK)
																										insert into t values(12,20,12);
																										(Query OK)
T1
	root@mysqldb 11:17:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;

	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| 139859108164160:1303:139859033429688    |                869622 |      2029 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |

	| 139859108164160:246:5:5:139859033426648 |                869622 |      2029 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 15, 15    | WAITING FOR THIS LOCK TO BE GRANTED 
	
	| 139859108163288:1303:139859033423736    |                869617 |      2023 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139859108163288:246:5:4:139859033420744 |                869617 |      2023 | t           | c          | RECORD    | X                      | GRANTED     | 10, 10    |
	| 139859108163288:246:5:8:139859033420744 |                869617 |      2023 | t           | c          | RECORD    | X                      | GRANTED     | 10, 30    |
	| 139859108163288:246:4:4:139859033421088 |                869617 |      2023 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP          | GRANTED     | 10        |
	| 139859108163288:246:4:8:139859033421088 |                869617 |      2023 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP          | GRANTED     | 30        |
	
	| 139859108163288:246:5:5:139859033421432 |                869617 |      2023 | t           | c          | RECORD    | X,GAP                  | GRANTED     | 15, 15    | HOLDS THE LOCK(S)
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	8 rows in set (0.02 sec)

	root@mysqldb 12:11:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+--------------------------------+------------------------+--------------------+
	| locked_index | locked_type | waiting_query                  | waiting_lock_mode      | blocking_lock_mode |
	+--------------+-------------+--------------------------------+------------------------+--------------------+
	| c            | RECORD      | insert into t values(12,12,12) | X,GAP,INSERT_INTENTION | X,GAP              |
	+--------------+-------------+--------------------------------+------------------------+--------------------+
	1 row in set (0.04 sec)

4.2.4 非唯一索引上等值查询并且加limit语句：

mysql> select c,id from t order by c asc;
+------+----+
| c    | id |
+------+----+
|    0 |  0 |
|    5 |  5 |
|   10 | 10 |
|   10 | 30 |
|   15 | 15 |
|   20 | 20 |
|   25 | 25 |
+------+----+
7 rows in set (0.00 sec)


4.2.5 非唯一索引上等值查询-Gap lock死锁 

	session A                                                 session B                                      
	begin;
	select id from t where c=10 lock in share mode;
	持有的锁：c：next-key lock：(5, 10] 和  c: gap lock ： (10, 15)
															  update t set d=d+1 where c=10;
															（Blocked）
															持有的锁: c: gap lock ： (5, 10)
															在等待的锁: c: record lock: [10]
	T1的
	insert into t values(8,8,8);
	（Blocked）
	在等待的锁: c: gap lock: (5, 10)
														     ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
	
	
	
	T1
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		| 139859108161544:1303:139859033411576    |                869642 |      2046 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL      |
		| 139859108161544:246:5:4:139859033408536 |                869642 |      2046 | t           | c          | RECORD    | X         | WAITING     | 10, 10    |

		| 139859108160672:1303:139859033405624    |       421334084871328 |      2043 | t           | NULL       | TABLE     | IS        | GRANTED     | NULL      |
		| 139859108160672:246:5:4:139859033402584 |       421334084871328 |      2043 | t           | c          | RECORD    | S         | GRANTED     | 10, 10    |
		| 139859108160672:246:5:5:139859033402928 |       421334084871328 |      2043 | t           | c          | RECORD    | S,GAP     | GRANTED     | 15, 15    |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		5 rows in set (0.00 sec)

		ENGINE_TRANSACTION_ID = 421334084871328 表示只读事务,  执行 'insert into t values(8,8,8);' 语句才开始申请写事务的ID, 事务ID 为 869643.
		
		验证了 事务启动的时机：
			begin/start transaction 命令并不是一个事务的起点，在执行到它们之后的第一个操作 InnoDB 表的语句，事务才真正启动，即这时候才分配事务ID；
			如果想要马上启动一个事务，可以使用 start transaction with consistent snapshot 这个命令。


		session B持有的 c: gap lock ：  (5,10) 的间隙锁, performance_schema.data_locks视图 没有列出来.
		再次验证了 performance_schema.data_locks 并不总是能看到全部的锁

		root@mysqldb 17:08:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+-------------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query                 | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+-------------------------------+-------------------+--------------------+
		| c            | RECORD      | update t set d=d+1 where c=10 | X                 | S                  |
		+--------------+-------------+-------------------------------+-------------------+--------------------+
		1 row in set (0.00 sec)
		
		

	死锁日志	

		------------------------
		LATEST DETECTED DEADLOCK
		------------------------
		2020-05-12 17:08:57 0x7f32defe7700
		*** (1) TRANSACTION:
		TRANSACTION 869642, ACTIVE 5 sec starting index read
		mysql tables in use 1, locked 1
		LOCK WAIT 2 lock struct(s), heap size 1136, 1 row lock(s)
		MySQL thread id 1991, OS thread handle 139855812097792, query id 57499 localhost root updating
		update t set d=d+1 where c=10

		*** (1) HOLDS THE LOCK(S):
		RECORD LOCKS space id 246 page no 5 n bits 80 index c of table `sbtest`.`t` trx id 869642 lock_mode X waiting
		Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
		 0: len 4; hex 8000000a; asc     ;;
		 1: len 4; hex 8000000a; asc     ;;


		*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
		RECORD LOCKS space id 246 page no 5 n bits 80 index c of table `sbtest`.`t` trx id 869642 lock_mode X waiting
		Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
		 0: len 4; hex 8000000a; asc     ;;
		 1: len 4; hex 8000000a; asc     ;;


		*** (2) TRANSACTION:
		TRANSACTION 869643, ACTIVE 64 sec inserting
		mysql tables in use 1, locked 1
		LOCK WAIT 5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 1
		MySQL thread id 1988, OS thread handle 139855811032832, query id 57510 localhost root update
		insert into t values(8,8,8)

		*** (2) HOLDS THE LOCK(S):
		RECORD LOCKS space id 246 page no 5 n bits 80 index c of table `sbtest`.`t` trx id 869643 lock mode S
		Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
		 0: len 4; hex 8000000a; asc     ;;
		 1: len 4; hex 8000000a; asc     ;;


		*** (2) WAITING FOR THIS LOCK TO BE GRANTED:
		RECORD LOCKS space id 246 page no 5 n bits 80 index c of table `sbtest`.`t` trx id 869643 lock_mode X locks gap before rec insert intention waiting
		Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
		 0: len 4; hex 8000000a; asc     ;;
		 1: len 4; hex 8000000a; asc     ;;
	
		*** WE ROLL BACK TRANSACTION (1)
		
		
		1. index C of table `sbtest`.`t` ：表示这个语句被锁住是因为表t 索引c的某个锁(表示在等的是表t 的辅助索引c 上面的锁)
		2. lock_mode X locks gap before rec insert intention waiting
			insert intention ：表示当前线程准备插入一个记录，这是一个插入意向锁, 可以认为它就是这个插入动作本身
			gap before res：表示这是一个间隙锁，而不是记录锁
		3. 结合1和2，说明事务A的insert语句被表t索引c上的间隙锁锁住
		
			# 理解了.
		
	
		错误日志中的死锁日志
			TRANSACTION 869642, ACTIVE 5 sec starting index read
			mysql tables in use 1, locked 1
			LOCK WAIT 2 lock struct(s), heap size 1136, 1 row lock(s)
			MySQL thread id 1991, OS thread handle 139855812097792, query id 57499 localhost root updating
			update t set d=d+1 where c=10
			RECORD LOCKS space id 246 page no 5 n bits 80 index c of table `sbtest`.`t` trx id 869642 lock_mode X waiting
			Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
			 0: len 4; hex 8000000a; asc     ;;
			 1: len 4; hex 8000000a; asc     ;;

			RECORD LOCKS space id 246 page no 5 n bits 80 index c of table `sbtest`.`t` trx id 869642 lock_mode X waiting
			Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
			 0: len 4; hex 8000000a; asc     ;;
			 1: len 4; hex 8000000a; asc     ;;

			TRANSACTION 869643, ACTIVE 64 sec inserting
			mysql tables in use 1, locked 1
			LOCK WAIT 5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 1
			MySQL thread id 1988, OS thread handle 139855811032832, query id 57510 localhost root update
			insert into t values(8,8,8)
			RECORD LOCKS space id 246 page no 5 n bits 80 index c of table `sbtest`.`t` trx id 869643 lock mode S
			Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
			 0: len 4; hex 8000000a; asc     ;;
			 1: len 4; hex 8000000a; asc     ;;

			RECORD LOCKS space id 246 page no 5 n bits 80 index c of table `sbtest`.`t` trx id 869643 lock_mode X locks gap before rec insert intention waiting
			Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
			 0: len 4; hex 8000000a; asc     ;;
			 1: len 4; hex 8000000a; asc     ;;

4.2.6 非唯一索引范围等值查询--order by desc --这个例子不好理解
	root@mysqldb 18:21:  [sbtest]> select c,id from t order by c asc;
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
	 

	session A									  session B									
	begin;
	select * from t where c>=15 and c<=20 order by c desc lock in share mode; 
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 20 |   20 |   20 |
	| 15 |   15 |   15 |
	+----+------+------+
	2 rows in set (0.00 sec)

												  insert into t values(6,6,6);


	root@mysqldb 18:04:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;

	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| 139859108160672:1303:139859033405624    |                869665 |      2056 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |

	| 139859108160672:246:5:4:139859033402584 |                869665 |      2056 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 10, 10    |

	| 139859108158928:1303:139859033393640    |       421334084869584 |      2054 | t           | NULL       | TABLE     | IS                     | GRANTED     | NULL      |
	| 139859108158928:246:5:7:139859033390712 |       421334084869584 |      2054 | t           | c          | RECORD    | S,GAP                  | GRANTED     | 25, 25    |

	| 139859108158928:246:5:4:139859033391056 |       421334084869584 |      2054 | t           | c          | RECORD    | S                      | GRANTED     | 10, 10    |

	| 139859108158928:246:5:5:139859033391056 |       421334084869584 |      2054 | t           | c          | RECORD    | S                      | GRANTED     | 15, 15    |
	| 139859108158928:246:5:6:139859033391056 |       421334084869584 |      2054 | t           | c          | RECORD    | S                      | GRANTED     | 20, 20    |
	| 139859108158928:246:4:5:139859033391400 |       421334084869584 |      2054 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP          | GRANTED     | 15        |
	| 139859108158928:246:4:6:139859033391400 |       421334084869584 |      2054 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP          | GRANTED     | 20        |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	9 rows in set (0.00 sec)

	root@mysqldb 18:23:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| locked_index | locked_type | waiting_query               | waiting_lock_mode      | blocking_lock_mode |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	| c            | RECORD      | insert into t values(6,6,6) | X,GAP,INSERT_INTENTION | S                  |
	+--------------+-------------+-----------------------------+------------------------+--------------------+
	1 row in set (0.00 sec)


4.2.6 非唯一索引范围等值查询--没有order by desc
	尾点延伸，跟 8.0.18 之前的 唯一索引范围 bug 一样。

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
		root@mysqldb 21:44:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
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

		root@mysqldb 21:44:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+--------------------------------+------------------------+--------------------+
		| locked_index | locked_type | waiting_query                  | waiting_lock_mode      | blocking_lock_mode |
		+--------------+-------------+--------------------------------+------------------------+--------------------+
		| c            | RECORD      | insert into t values(11,11,11) | X,GAP,INSERT_INTENTION | S                  |
		+--------------+-------------+--------------------------------+------------------------+--------------------+
		1 row in set (0.00 sec)


	T2
		root@mysqldb 21:44:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
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

		root@mysqldb 21:49:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+-------------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query                 | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+-------------------------------+-------------------+--------------------+
		| c            | RECORD      | update t set d=d+1 where c=25 | X                 | S                  |
		+--------------+-------------+-------------------------------+-------------------+--------------------+
		1 row in set (0.00 sec)


	这里session C为什么会被锁住：
		next-key lock, c>=15 的加锁范围: prmary: next-key lock: (10,15]
		c<=20 加锁范围是 c:next-key lock: (15, 20] + (20, 25]
		至于为什么会锁住 c=25这一行记录，是因为 c<=20 是范围查询，范围查询就需要往后找，直到找到不满足条件的第一个值为止，所以找到 c=25 这一行，但是这里又不是等值查询，所以用不到优化2.
		--理解了。
		
4.2.7 非唯一索引in等值查询的加锁过程

	mysql> select @@global.transaction_isolation;
	+--------------------------------+
	| @@global.transaction_isolation |
	+--------------------------------+
	| REPEATABLE-READ                |
	+--------------------------------+
	1 row in set (0.00 sec)

	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.00 sec)

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)


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

	begin;
	select id from t where c in(5,20,10) lock in share mode;
	=
	select id from t where c in(5,10,20) lock in share mode;
	+----+
	| id |
	+----+
	|  5 |
	| 10 |
	| 20 |
	+----+
	3 rows in set (0.00 sec)


	mysql> desc select id from t where c in(5,20,10) lock in share mode;
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+--------------------------+
	| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra                    |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+--------------------------+
	|  1 | SIMPLE      | t     | NULL       | range | c             | c    | 5       | NULL |    3 |   100.00 | Using where; Using index |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+--------------------------+
	1 row in set, 1 warning (0.00 sec)

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	| 139811159239272:1303:139811050549928    |       421286135949928 |        95 | t           | NULL       | TABLE     | IS        | GRANTED     | NULL      |
	| 139811159239272:246:5:3:139811050546888 |       421286135949928 |        95 | t           | c          | RECORD    | S         | GRANTED     | 5, 5      |
	| 139811159239272:246:5:4:139811050546888 |       421286135949928 |        95 | t           | c          | RECORD    | S         | GRANTED     | 10, 10    |
	| 139811159239272:246:5:6:139811050546888 |       421286135949928 |        95 | t           | c          | RECORD    | S         | GRANTED     | 20, 20    |
	| 139811159239272:246:5:4:139811050547232 |       421286135949928 |        95 | t           | c          | RECORD    | S,GAP     | GRANTED     | 10, 10    |
	| 139811159239272:246:5:5:139811050547232 |       421286135949928 |        95 | t           | c          | RECORD    | S,GAP     | GRANTED     | 15, 15    |
	| 139811159239272:246:5:7:139811050547232 |       421286135949928 |        95 | t           | c          | RECORD    | S,GAP     | GRANTED     | 25, 25    |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	7 rows in set (0.00 sec)

	session A的加锁范围
		c=5
			c: next-key lock: (0,5]
			c: gap lock: (5,10)
		c=10:
			c: record lock: [10]
			c: gap lock: (10, 15)
		c=20:
			c: next-key lock: (15,20]
			c: gap lock: (20, 25)
			
	根据加锁的基本单位是 next-key, 每个等值条件的加锁范围
		c=5
			c: next-key lock: (0,5]
		c=10
			c: next-key lock: (5,10]
			c: gap lock: (10, 15)	
		c=20:
			c: next-key lock: (15,20]
			c: gap lock: (20, 25)


 4.2.8 非唯一索引in等值查询&order by的加锁过程          
    begin; 
    select id from t where c in(5,20,10) order by c desc for update;
    +----+
	| id |
	+----+
	| 20 |
	| 10 |
	|  5 |
	+----+
	3 rows in set (0.00 sec)

	由于语句里面是 order by c desc， 这三个记录锁的加锁顺序，是先锁 c=20，然后 c=10，最后是 c=5。

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139811159239272:1352:139811050549928    |               1004658 |       145 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139811159239272:295:5:3:139811050546888 |               1004658 |       145 | t           | c          | RECORD    | X             | GRANTED     | 5, 5      |
	| 139811159239272:295:5:4:139811050546888 |               1004658 |       145 | t           | c          | RECORD    | X             | GRANTED     | 10, 10    |
	| 139811159239272:295:5:6:139811050546888 |               1004658 |       145 | t           | c          | RECORD    | X             | GRANTED     | 20, 20    |
	| 139811159239272:295:4:3:139811050547232 |               1004658 |       145 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 5         |
	| 139811159239272:295:4:4:139811050547232 |               1004658 |       145 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 10        |
	| 139811159239272:295:4:6:139811050547232 |               1004658 |       145 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 20        |
	| 139811159239272:295:5:5:139811050547576 |               1004658 |       145 | t           | c          | RECORD    | X,GAP         | GRANTED     | 15, 15    |
	| 139811159239272:295:5:7:139811050547576 |               1004658 |       145 | t           | c          | RECORD    | X,GAP         | GRANTED     | 25, 25    |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.01 sec)

