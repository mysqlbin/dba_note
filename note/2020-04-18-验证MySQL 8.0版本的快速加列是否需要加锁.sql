1. 数据库版本号
2. 表的DDL
3. 事务的执行顺序
4. show processlist
5. 小结


1. 数据库版本号
	root@mysqldb 15:23:  [(none)]> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)

2. 表的DDL
	CREATE TABLE `test1` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(50) NOT NULL DEFAULT '',
	  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


3. 事务的执行顺序
	session A             			 session B
	begin;
	delete from test1 where id=1;

									 alter table test1 add column age int(11) not null default 0 comment '年龄';
									 (Blocked)
	
4. show processlist
	root@mysqldb 15:25:  [(none)]> show processlist;
	+------+-----------------+--------------------+------+------------------+-------+---------------------------------------------------------------+------------------------------------------------------------------------------+
	| Id   | User            | Host               | db   | Command          | Time  | State                                                         | Info                                                                         |
	+------+-----------------+--------------------+------+------------------+-------+---------------------------------------------------------------+------------------------------------------------------------------------------+
	|    4 | event_scheduler | localhost          | NULL | Daemon           | 19071 | Waiting on empty queue                                        | NULL                                                                         |
	|   55 | keepalived      | 192.168.0.92:39330 | NULL | Binlog Dump GTID | 18514 | Master has sent all binlog to slave; waiting for more updates | NULL
	| 1306 | root            | localhost          | db3  | Query            |     5 | Waiting for table metadata lock                               | alter table test1 add column age int(11) not null default 0 comment '年龄'   |
	| 1307 | root            | localhost          | NULL | Query            |     0 | starting                                                      | show processlist                                                             |
	+------+-----------------+--------------------+------+------------------+-------+---------------------------------------------------------------+------------------------------------------------------------------------------+
	12 rows in set (0.00 sec)


5. 小结
	快速加列是需要加MDL写锁的。
	