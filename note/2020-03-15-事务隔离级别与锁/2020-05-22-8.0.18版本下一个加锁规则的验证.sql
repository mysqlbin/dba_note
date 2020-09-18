

1. 表结构和数据的初始化
2. RR隔离级别
	2.1 实验1
	2.2 实验2
	2.3 实验3
	2.4 实验4
	2.5 实验5

3. RC隔离级别
	3.1 实验1
	3.2 实验2
	3.3 实验3
	3.4 实验4
	3.5 实验5
	
1. 表结构和数据的初始化
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
	
	DROP PROCEDURE IF EXISTS `idata`;
	DELIMITER ;;
	CREATE DEFINER=`root`@`%` PROCEDURE `idata`()
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
	
2. RR隔离级别

2.1 实验1
	root@mysqldb 17:50:  [zst]> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.00 sec)

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
	
	
2.2 实验2
	begin;
	mysql> select * from t where id>=3 and  id<=5 lock in share mode;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	3 rows in set (0.00 sec)
										
	root@mysqldb 17:51:  [zst]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+------------------------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA              |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+------------------------+
	| 139811159241888:1338:139811050567864    |       421286135952544 |       167 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL                   |
	| 139811159241888:281:4:4:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3                      |
	| 139811159241888:281:4:1:139811050565168 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S             | GRANTED     | supremum pseudo-record |
	| 139811159241888:281:4:5:139811050565168 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 4                      |
	| 139811159241888:281:4:6:139811050565168 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 5                      |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+------------------------+
	5 rows in set (0.00 sec)

2.3 实验3

	session A            session B

	select * from t where id>=3 and  id<=4 lock in share mode;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	+----+------+------+
	2 rows in set (0.00 sec)

						begin;
						delete from t where id=5;
						(Query OK)
						
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139811159241888:1338:139811050567864    |       421286135952544 |       167 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139811159241888:281:4:4:139811050564824 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 139811159241888:281:4:5:139811050565168 |       421286135952544 |       167 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 4         |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	3 rows in set (0.00 sec)


2.4 实验4

	begin;

	select * from t where id<=5 lock in share mode;

	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	5 rows in set (4.69 sec)
							begin;
							insert into t(c,d) values(6,6);
							(Blocked)
							
	root@mysqldb 18:09:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE          | LOCK_STATUS | LOCK_DATA              |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
	| 139811159242760:1338:139811050573816    |               1004714 |       168 | t           | NULL       | TABLE     | IX                 | GRANTED     | NULL                   |
	| 139811159242760:281:4:1:139811050570776 |               1004714 |       168 | t           | PRIMARY    | RECORD    | X,INSERT_INTENTION | WAITING     | supremum pseudo-record |
	| 139811159239272:1338:139811050549928    |       421286135949928 |       170 | t           | NULL       | TABLE     | IS                 | GRANTED     | NULL                   |
	| 139811159239272:281:4:1:139811050546888 |       421286135949928 |       170 | t           | PRIMARY    | RECORD    | S                  | GRANTED     | supremum pseudo-record |
	| 139811159239272:281:4:2:139811050546888 |       421286135949928 |       170 | t           | PRIMARY    | RECORD    | S                  | GRANTED     | 1                      |
	| 139811159239272:281:4:3:139811050546888 |       421286135949928 |       170 | t           | PRIMARY    | RECORD    | S                  | GRANTED     | 2                      |
	| 139811159239272:281:4:4:139811050546888 |       421286135949928 |       170 | t           | PRIMARY    | RECORD    | S                  | GRANTED     | 3                      |
	| 139811159239272:281:4:5:139811050546888 |       421286135949928 |       170 | t           | PRIMARY    | RECORD    | S                  | GRANTED     | 4                      |
	| 139811159239272:281:4:6:139811050546888 |       421286135949928 |       170 | t           | PRIMARY    | RECORD    | S                  | GRANTED     | 5                      |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
	9 rows in set (0.01 sec)


2.5 实验5

	begin;
	insert into t(c,d) values(6,6);
							
						begin;
						select * from t where id<=5 lock in share mode;
						(Blocked)
						
	参考笔记 《2020-05-24-innodb_autoinc_lock_mode-验证 8.0.18版本是否存在主键记录锁扩大.sql》


3. RC隔离级别
	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.00 sec)
	
	
3.1 实验1	
	
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

	
3.2 实验2

	begin;
	mysql> select * from t where id>=3 and  id<=5 lock in share mode;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	3 rows in set (0.00 sec)
										
	root@mysqldb 11:08:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140570760526704:1338:140570655811576    |       422045737237360 |        58 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140570760526704:281:4:4:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140570760526704:281:4:5:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 140570760526704:281:4:6:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 5         |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	4 rows in set (0.00 sec)

3.3 实验3

	session A            session B
	begin;
	select * from t where id>=3 and  id<=4 lock in share mode;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	+----+------+------+
	2 rows in set (0.00 sec)

						begin;
						delete from t where id=5;
						(Query OK)
						
	root@mysqldb 11:09:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140570760526704:1338:140570655811576    |       422045737237360 |        58 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140570760526704:281:4:4:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140570760526704:281:4:5:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	3 rows in set (0.00 sec)

3.4 实验4

	begin;
	select * from t where id<=5 lock in share mode;

	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	5 rows in set (4.69 sec)
							begin;
							insert into t(c,d) values(6,6);
							(Query OK)	
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140570760527576:1338:140570655817592    |               1005103 |        59 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140570760526704:1338:140570655811576    |       422045737237360 |        58 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140570760526704:281:4:2:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 140570760526704:281:4:3:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 140570760526704:281:4:4:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140570760526704:281:4:5:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 140570760526704:281:4:6:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 5         |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.00 sec)



3.5 实验5

	begin;
	insert into t(c,d) values(6,6);
							
						begin;
						select * from t where id<=5 lock in share mode;
						(Blocked)
						
						