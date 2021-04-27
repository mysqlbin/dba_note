




CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB;
insert into t values(0,0,0),(5,5,5),(10,10,10),(15,15,15),(20,20,20),(25,25,25);




root@mysqldb 14:24:  [test_Db]> select version();
+------------+
| version()  |
+------------+
| 5.7.22-log |
+------------+
1 row in set (0.01 sec)




id=5 在RR和RC级别下的锁


	root@mysqldb 14:24:  [(none)]> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.00 sec)
	
	
	root@mysqldb 14:24:  [test_Db]> select * from t;
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


	事务的执行次序
	session A           session B

	begin;	            
	INSERT INTO `t` (`id`, `c`, `d`) VALUES (6, '6', '6');
	
	
						begin;	  
						SELECT * from t WHERE id =5 LOCK IN SHARE MODE;
						+----+------+------+
						| id | c    | d    |
						+----+------+------+
						|  5 |    5 |    5 |
						+----+------+------+
						1 row in set (0.00 sec)
						
	
	
	
	session B的加锁分析如下： 
	   1. id=5的记录存在
	   2. 根据原则1，Session A 的加锁范围为 PRIMARY： next-key lock：(5,10]；
	   3. 优化 1：索引上的等值查询，给唯一索引加锁的时候，next-key lock退化为行锁。          
	   4. 所以 Session A 的加锁范围为 PRIMARY: record-lock:id=5。
	   
   
	
						