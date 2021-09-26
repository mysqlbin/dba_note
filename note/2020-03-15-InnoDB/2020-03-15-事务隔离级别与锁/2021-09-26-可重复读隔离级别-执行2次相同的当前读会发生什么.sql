

1. 环境
2. 初始化表结构和数据
3. 事务的执行次序
4. 小结


1. 环境

	mysql> show global variables like '%iso%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	+-----------------------+-----------------+
	1 row in set (0.01 sec)

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)


2. 初始化表结构和数据

	drop table if exists t_20210926;

	CREATE TABLE `t_20210926` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;



	insert into t_20210926 values(null, 1,1);
	insert into t_20210926 values(null, 3,3);
	insert into t_20210926 values(null, 4,4);


	mysql> select * from t_20210926;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    3 |    3 |
	|  3 |    4 |    4 |
	+----+------+------+
	3 rows in set (0.00 sec)



3. 事务的执行次序
	
	session A           session B 
	begin;				begin;	
	
	select * from t_20210926 where c=3 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  2 |    3 |    3 |
	+----+------+------+
	1 row in set (0.00 sec)


						insert into t_20210926 values(null, 3,5);
						(Blocked)
							
	select * from t_20210926 where c=3 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  2 |    3 |    3 |
	+----+------+------+
	1 row in set (0.00 sec)
	
	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| 139676974841296:1089:139676899936744   |                 73507 |        59 | t_20210926  | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139676974841296:32:5:4:139676899933816 |                 73507 |        59 | t_20210926  | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 4, 3      |
	| 139676974840424:1089:139676899930792   |                 73506 |        58 | t_20210926  | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 139676974840424:32:5:3:139676899927752 |                 73506 |        58 | t_20210926  | c          | RECORD    | X                      | GRANTED     | 3, 2      |
	| 139676974840424:32:4:3:139676899928096 |                 73506 |        58 | t_20210926  | PRIMARY    | RECORD    | X,REC_NOT_GAP          | GRANTED     | 2         |
	| 139676974840424:32:5:4:139676899928440 |                 73506 |        58 | t_20210926  | c          | RECORD    | X,GAP                  | GRANTED     | 4, 3      |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	6 rows in set (0.00 sec)


4. 小结

	repeatable read是隔离级别，这个也要求当前读是repeatable的，即多次select for update/share要看到同样的结果，正因为此所以才需要Gap lock呀 
	https://dev.mysql.com/doc/refman/8.0/en/innodb-transaction-isolation-levels.html








