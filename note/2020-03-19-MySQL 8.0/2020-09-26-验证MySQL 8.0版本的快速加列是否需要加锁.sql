
1. 初始化表结构、数据、数据库版本号
2. 验证快速加列是否加MDL写锁
3. 验证快速加列是否加MDL写锁--指定ALGORITHM=INSTANT
4. 小结


1. 初始化表结构、数据、数据库版本号

	CREATE TABLE `t` (
	  `id` bigint NOT NULL AUTO_INCREMENT,
	  `c` int DEFAULT NULL,
	  `d` int DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


	INSERT INTO `zst`.`t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	INSERT INTO `zst`.`t` (`id`, `c`, `d`) VALUES ('2', '2', '2');
	INSERT INTO `zst`.`t` (`id`, `c`, `d`) VALUES ('3', '3', '3');
	INSERT INTO `zst`.`t` (`id`, `c`, `d`) VALUES ('4', '4', '4');
	INSERT INTO `zst`.`t` (`id`, `c`, `d`) VALUES ('5', '5', '5');

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.19    |
	+-----------+
	1 row in set (0.00 sec)
	
	
2. 验证快速加列是否加MDL写锁
	session A             			 session B
	begin;
	delete from t where id=1;
	Query OK, 1 row affected (0.00 sec)
	
									 alter table t add column age int(11) not null default 0 comment 'age';
									 (Blocked)
	
	mysql> show processlist;
	+----+-----------------+---------------------+------+---------+------+---------------------------------+-----------------------------------------------------------------------+
	| Id | User            | Host                | db   | Command | Time | State                           | Info                                                                  |
	+----+-----------------+---------------------+------+---------+------+---------------------------------+-----------------------------------------------------------------------+
	|  4 | event_scheduler | localhost           | NULL | Daemon  |  388 | Waiting on empty queue          | NULL                                                                  |
	|  8 | root            | localhost           | zst  | Sleep   |   36 |                                 | NULL                                                                  |
	| 10 | root            | localhost           | NULL | Query   |    0 | starting                        | show processlist                                                      |
	| 11 | root            | 192.168.1.100:10895 | NULL | Sleep   |   49 |                                 | NULL                                                                  |
	| 12 | root            | 192.168.1.100:10897 | zst  | Sleep   |   42 |                                 | NULL                                                                  |
	| 13 | root            | 192.168.1.100:10906 | zst  | Sleep   |  326 |                                 | NULL                                                                  |
	| 14 | root            | localhost           | zst  | Query   |    4 | Waiting for table metadata lock | alter table t add column age int(11) not null default 0 comment 'age' |
	+----+-----------------+---------------------+------+---------+------+---------------------------------+-----------------------------------------------------------------------+
	7 rows in set (0.00 sec)



3. 验证快速加列是否加MDL写锁--指定ALGORITHM=INSTANT


	session A             			 session B
	begin;
	select * from t limit 1;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	+----+------+------+
	1 row in set (0.00 sec)

									 alter table t add column age int(11) not null default 0 comment 'age', ALGORITHM = INSTANT;	
									 (Blocked)		
									 
	mysql> show processlist;
	+----+-----------------+---------------------+------+---------+------+---------------------------------+--------------------------------------------------------------------------------------------+
	| Id | User            | Host                | db   | Command | Time | State                           | Info                                                                                       |
	+----+-----------------+---------------------+------+---------+------+---------------------------------+--------------------------------------------------------------------------------------------+
	|  4 | event_scheduler | localhost           | NULL | Daemon  |  198 | Waiting on empty queue          | NULL                                                                                       |
	|  8 | root            | localhost           | zst  | Sleep   |   69 |                                 | NULL                                                                                       |
	| 10 | root            | localhost           | NULL | Query   |    0 | starting                        | show processlist                                                                           |
	| 11 | root            | 192.168.1.100:10895 | NULL | Sleep   |  151 |                                 | NULL                                                                                       |
	| 12 | root            | 192.168.1.100:10897 | zst  | Sleep   |  129 |                                 | NULL                                                                                       |
	| 13 | root            | 192.168.1.100:10906 | zst  | Sleep   |  136 |                                 | NULL                                                                                       |
	| 14 | root            | localhost           | zst  | Query   |    5 | Waiting for table metadata lock | alter table t add column age int(11) not null default 0 comment 'age', ALGORITHM = INSTANT |
	+----+-----------------+---------------------+------+---------+------+---------------------------------+--------------------------------------------------------------------------------------------+
	7 rows in set (0.00 sec)
	
	

4. 小结

	快速加列是需要加MDL写锁的。
	http://blog.itpub.net/15498/viewspace-2645164/  
		Instant add column功能自MySQL 8.0.12版本引入，INSTANT操作仅修改数据字典中的元数据。在准备和执行期间，不会在表上采用独占元数据锁， 并且表数据不受影响，从而使操作立即生效。允许并发DML。
		--这里感觉不对。
		--实践出真知，对网上的知识点，不可全信，要有自己的判断。
		
		
		
	For the duraton of instant adding column, MDL will be placed and maintained
on the table.