

	drop table if exists t;
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
	
	mysql> select * from t;
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

	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.00 sec)

	root@mysqldb 18:30:  [(none)]> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.17    |
	+-----------+
	1 row in set (0.00 sec)


实验1
		
	session A            session B
	begin;
	delete from t where id=5;
						begin;
						select * from t where id>=3 and  id<=4 lock in share mode;
						(Blocked)
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139885313141328:1062:139885205844056  |                  2569 |        58 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139885313141328:5:4:6:139885205841016 |                  2569 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 5         |
	| 139885313142192:1062:139885205850008  |       421360289852848 |        59 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139885313142192:5:4:4:139885205847080 |       421360289852848 |        59 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 139885313142192:5:4:5:139885205847424 |       421360289852848 |        59 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 4         |
	| 139885313142192:5:4:6:139885205847768 |       421360289852848 |        59 | t           | PRIMARY    | RECORD    | S             | WAITING     | 5         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	6 rows in set (0.02 sec)

	
实验2

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
						(Blocked)
						
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139885313142192:1062:139885205850008  |                  2572 |        59 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139885313142192:5:4:6:139885205847080 |                  2572 |        59 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 5         |
	| 139885313141328:1062:139885205844056  |       421360289851984 |        58 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139885313141328:5:4:4:139885205841016 |       421360289851984 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 139885313141328:5:4:5:139885205841360 |       421360289851984 |        58 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 4         |
	| 139885313141328:5:4:6:139885205841360 |       421360289851984 |        58 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 5         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	6 rows in set (0.00 sec)


	
实验3

	root@mysqldb 09:20:  [(none)]> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.01 sec)
					
					
	CREATE TABLE `t2` (
	  `id` int(11) NOT NULL,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB;
	insert into t2 values(0,0,0),(5,5,5),(10,10,10),(15,15,15),(20,20,20),(25,25,25);

	root@mysqldb 09:27:  [sbtest]> select * from t2;
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

	session A       session B   

	begin;
	select * from t2 where id=7 for update;
						
					begin;
					select * from t2 where id=10 for update;

					
	session A 的加锁范围: primary: gap lock: (5, 10)
	session B 的加锁过程: 加锁的基本单位是 next-key lock: (5,10], 根据优化1, 给唯一索引上的等值查询, next-key lock 会退化为 record lock, 因为加锁范围是 primary: record lock: [10]
	为什么 session B 加锁没退化之前不会session A 阻塞, 因为 gap lock 和 跟 gap lock 兼容的.

	