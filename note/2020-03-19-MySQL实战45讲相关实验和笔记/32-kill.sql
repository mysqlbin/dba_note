
如果一个线程的状态是KILL_CONNECTION，就把Command列显示成Killed。


MySQL 的两个 kill 命令：
	kill query thread_id: 表示终止这个线程中正在执行的语句；
	kill [connection] thread_id: 表示断开这个线程的连接，如果这个线程有语句正在执行，要先停止正在执行的语句。

 
 
create  database db1 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

use db1;
CREATE TABLE `t` (
  `id` INT(11) NOT NULL,
  `c` INT(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

INSERT INTO t VALUES (1,1);


session A             session B             		session C
begin;  
update t set c=c+1 where id=1;
				      update t set c=c+1 where id=1;
					  (Block)								
													
												    kill query 29;   
					  ERROR 1317 (70100): Query
					  execution was interrupted		


mysql> show processlist;
+----+----------+--------------------+------+---------+------+----------+-------------------------------+
| Id | User     | Host               | db   | Command | Time | State    | Info                          |
+----+----------+--------------------+------+---------+------+----------+-------------------------------+
| 28 | root     | 192.168.0.54:44308 | NULL | Query   |    0 | starting | show processlist              |
| 29 | root     | 192.168.0.54:44310 | db1  | Query   |    7 | updating | update t set c=c+1 where id=1 |
+----+----------+--------------------+------+---------+------+----------+-------------------------------+
7 rows in set (0.00 sec)

mysql> kill query 29;
Query OK, 0 rows affected (0.00 sec)

mysql> show processlist;
+----+----------+--------------------+------+---------+------+----------+------------------+
| Id | User     | Host               | db   | Command | Time | State    | Info             |
+----+----------+--------------------+------+---------+------+----------+------------------+
| 28 | root     | 192.168.0.54:44308 | NULL | Query   |    0 | starting | show processlist |
| 29 | root     | 192.168.0.54:44310 | db1  | Sleep   |   66 |          | NULL             |
+----+----------+--------------------+------+---------+------+----------+------------------+
7 rows in set (0.00 sec)





set global innodb_thread_concurrency=2; 

session A					session B					session C				session D		session E
SELECT SLEEP(100) FROM t;	SELECT SLEEP(100) FROM t;				
														SELECT * FROM t;
														(Blocked)		
																				show processlist;
																				(1st)
																				kill query 28;
																				(无效) 
																						
																				show processlist;
																				(2st)
																					
																								kill 28;
																							
														ERROR 2013 (HY000): Lost
														connection to MySQL server during query
														
														show processlist;
														(3st)
																											
1st:	
mysql> show processlist;
+----+----------+--------------------+------+---------+------+--------------+--------------------------+
| Id | User     | Host               | db   | Command | Time | State        | Info                     |
+----+----------+--------------------+------+---------+------+--------------+--------------------------+
| 27 | root     | 192.168.0.54:44306 | db1  | Query   |    0 | starting     | show processlist         |
| 28 | root     | 192.168.0.54:44308 | db1  | Query   |    6 | Sending data | SELECT * FROM t          |
| 29 | root     | 192.168.0.54:44310 | db1  | Query   |    8 | User sleep   | SELECT SLEEP(100) FROM t |
| 30 | root     | 192.168.0.54:44312 | db1  | Query   |   10 | User sleep   | SELECT SLEEP(100) FROM t |
+----+----------+--------------------+------+---------+------+--------------+--------------------------+
8 rows in set (0.00 sec)


2st: 
mysql> show processlist;
+----+----------+--------------------+------+---------+------+--------------+--------------------------+
| Id | User     | Host               | db   | Command | Time | State        | Info                     |
+----+----------+--------------------+------+---------+------+--------------+--------------------------+
| 27 | root     | 192.168.0.54:44306 | db1  | Query   |    0 | starting     | show processlist         |
| 28 | root     | 192.168.0.54:44308 | db1  | Query   |   31 | Sending data | SELECT * FROM t          |
| 29 | root     | 192.168.0.54:44310 | db1  | Query   |   33 | User sleep   | SELECT SLEEP(100) FROM t |
| 30 | root     | 192.168.0.54:44312 | db1  | Query   |   35 | User sleep   | SELECT SLEEP(100) FROM t |
+----+----------+--------------------+------+---------+------+--------------+--------------------------+
8 rows in set (0.00 sec)

3st: 
mysql> show processlist;
+----+----------+--------------------+------+---------+------+--------------+--------------------------+
| Id | User     | Host               | db   | Command | Time | State        | Info                     |
+----+----------+--------------------+------+---------+------+--------------+--------------------------+
| 27 | root     | 192.168.0.54:44306 | db1  | Query   |    0 | starting     | show processlist         |
| 28 | root     | 192.168.0.54:44308 | db1  | Killed  |   55 | Sending data | SELECT * FROM t          |
| 29 | root     | 192.168.0.54:44310 | db1  | Query   |   57 | User sleep   | SELECT SLEEP(100) FROM t |
| 30 | root     | 192.168.0.54:44312 | db1  | Query   |   59 | User sleep   | SELECT SLEEP(100) FROM t |
+----+----------+--------------------+------+---------+------+--------------+--------------------------+
9 rows in set (0.00 sec)



1. sesssion C 执行的时候被堵住了；但是 session D 执行的 kill query C 命令却没什么效果
	等行锁时，使用的是 pthread_cond_timedwait 函数，这个等待状态可以被唤醒。
	本例中, 28 号线程的等待逻辑为：
		每 10 毫秒判断一下是否可以进入 InnoDB 执行，如果不行，就调用 nanosleep 函数进入 sleep 状态。
	虽然 28 号线程的状态已经被设置成了 KILL_QUERY，但是在这个等待进入 InnoDB 的循环过程中
		并没有去判断线程的状态，因此根本不会进入终止逻辑阶段。
		
2. session E执行KILL CONNECTION，断开session C的连接，Command列变成了Killed
	把 28 号线程状态设置为 KILL_CONNECTION；
	关掉 28 号线程的网络连接; 因为有这个操作，所以会看到，这时候 session C 收到了断开连接的提示。
	
3. 执行show processlist的特别逻辑:
	如果一个线程的状态是 KILL_CONNECTION，就把 Command 列显示成 Killed。
	即使是客户端退出了，这个线程的状态仍然是在等待中。
	线程退出:
		只有等到满足进入 InnoDB 的条件后，session C 的查询语句继续执行
		然后才有可能判断到线程状态已经变成了 KILL_QUERY 或者 KILL_CONNECTION，再进入终止逻辑阶段。



kill命令无效的情况：
	
	1. 线程没有执行到判断线程状态的逻辑
		例如本文章的28号线程
		跟这种情况相同的，还有由于 IO 压力过大，读写 IO 的函数一直无法返回，导致不能及时判断线程的状态。
	
	2. 终止逻辑耗时较长
		从 show processlist 结果上看也是 Command=Killed，需要等到终止逻辑完成，语句才算真正完成。
		比较常见的场景有以下几种：
			1. 超大事务执行期间被 kill
			   这时候，回滚操作需要对事务执行期间生成的所有新数据版本做回收操作，耗时很长。		
			2. 大查询回滚
			   如果查询过程中生成了比较大的临时文件，加上此时文件系统压力大，删除临时文件可能需要等待 IO 资源，导致耗时较长。	
			3. DDL 命令执行到最后阶段，如果被 kill，需要删除中间过程的临时文件，也可能受 IO 资源影响耗时较久。
			   
	
Ctrl+C:

	在客户端执行 Ctrl+C, 不会直接终止线程;
	
	在客户端的操作只能操作到客户端的线程，客户端和服务端只能通过网络交互，是不可能直接操作服务端线程的。
	
	而由于 MySQL 是停等协议，所以这个线程执行的语句还没有返回的时候，再往这个连接里面继续发命令也是没有用的。
	
	Ctrl+C的逻辑:
	
		实际上，执行 Ctrl+C 的时候，是 MySQL 客户端另外启动一个连接，然后发送一个 kill query 命令
		要 kill 掉一个线程，还涉及到后端的很多操作
		因此, 在客户端执行完 Ctrl+C 并非万事大吉。

	
	
连接等待和-A参数:
	连接等待现象:
		db1这个库有很多张表, 每次用客户端连接都会卡在下面这个界面上
		Reading table information for completion of table and column names You can turn off this feature to get a quicker startup with -A
		如果db1 这个库里表很少的话，连接起来就会很快，可以很快进入输入命令的状态。
		
		
		客户端在连接成功后需要做的操作:
		1. 每个客户端在和服务端建立连接的时候，需要做的事情就是 TCP 握手、用户校验、获取权限。
			但这几个操作，跟库里面表的个数无关。
		
		2. 当使用默认参数连接的时候，客户端在连接成功后，需要多做一些操作实现一个本地库名和表名补全的功能
			1. 执行 show databases；
			2. 切到 db1 库，执行 show tables；
			3. 把这两个命令的结果用于构建一个本地的哈希表。
				最花时间的就是在本地构建哈希表的操作。
				所以，当一个库中的表个数非常多的时候，这一步就会花比较长的时间。	
			
		我们感知到的连接过程慢，其实并不是连接慢，也不是服务端慢，而是客户端慢。
	
	
	-A参数: 
		You can turn off this feature to get a quicker startup with -A
		如果在连接命令中加上 -A，就可以关掉这个自动补全的功能，然后客户端就可以快速返回了。

	
	
-quick参数:

–quick 参数的意思，是让客户端变得更快。	

MySQL 客户端发送请求后，接收服务端返回结果的方式有两种：
	1. 本地缓存，也就是在本地开一片内存，先把结果存起来
		MySQL 客户端默认使用本地缓存
		如果你用 API 开发，对应的就是 mysql_store_result 方法。
    2. 不缓存，读一个处理一个
		加上 –quick 参数，就会使用不缓存的方式
		如果你用 API 开发，对应的就是 mysql_use_result 方法。
		采用不缓存的方式时，如果本地处理得慢，就会导致服务端发送结果被阻塞，因此会让服务端变慢。
	
	
-quick参数的3个作用:
	跳过表名自动补全功能
	mysql_store_result 需要申请本地内存来缓存查询结果，如果查询结果太大，会耗费较多的本地内存，可能会影响客户端本地机器的性能；
	不会把执行命令记录到本地的命令历史文件。
	
	
show processlist.command='Killed'的解决办法:

	发现一个线程处于 Killed 状态，可以通过影响系统环境，让这个 Killed 状态尽快结束。
	比如，如果是 InnoDB 并发度的问题，你就可以临时调大 innodb_thread_concurrency 的值，或者停掉别的线程，让出位置给这个线程执行。
	而如果是回滚逻辑由于受到 IO 资源限制执行得比较慢，就通过减少系统压力让它加速。
	


kill query：用于停止正在执行的SQL语句；
kill connection：用于关闭数据库连接，同时停止连接中正在执行的SQL语句。



	
问题：

	如果一个事务被 kill 之后，持续处于回滚状态，从恢复速度的角度看，你是应该重启等它执行结束，还是应该强行重启整个 MySQL 进程。
	
	答：
		因为重启之后该做的回滚动作还是不能少的，所以从恢复速度的角度来说，应该让它自己结束。
		当然，如果这个语句可能会占用别的锁，或者由于占用 IO 资源过多，从而影响到了别的语句执行的话，就需要先做主备切换，切到新主库提供服务。
		切换之后别的线程都断开了连接，自动停止执行。
		接下来还是等它自己执行完成。
		这个操作属于我们在文章中说到的，减少系统压力，加速终止逻辑。
		
	即便是MySQL重启, 也是需要对未提交的事务进行回滚操作的,保证数据库的一致性。 
	
	-- 重启的代价很高， 关于数据的回滚，跟 kill 连接一样，需要对未提交的事务进行回滚操作，导致这一段时间的数据库不可以对外服务。
		相关笔记 《2019-07-27-MySQL重启之后长事务的undo回滚》、《2020-01-06-redo-recovery日志解读.sql》


---------------------------------------------------------------------------
	
mysql> show tables;
	22742 rows in set (0.14 sec)	
	
---------------------------------------------------------------------------
	
shell> mysql -h 192.168.0.242 -uljb_user -p123456abc base_db
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 39
Server version: 5.7.22-log MySQL Community Server (GPL)

Copyright (c) 2000, 2017, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

---------------------------------------------------------------------------

shell>  mysql -h 192.168.0.242 -uljb_user -p123456abc base_db -A
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 40
Server version: 5.7.22-log MySQL Community Server (GPL)

Copyright (c) 2000, 2017, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
	
	
	
------------------------------------------------------------------------------------------------------------------------------
	
kill 1个大事务的线程会发生什么
	终止当前语句和回滚事务的关系？
	update t_20201023 set age=0;
	-- 更新语句执行到一半，触发 kill 线程


	root@mysqldb 17:01:  [test_db]> select * from t1;
	+----+-----+---------------------+
	| ID | age | tEndTime            |
	+----+-----+---------------------+
	|  2 |   2 | 2020-07-13 14:23:57 |
	|  3 |   3 | 2020-07-13 14:24:00 |
	|  4 |   4 | 2020-07-13 14:24:03 |
	|  5 |   5 | 2020-07-13 14:24:05 |
	|  6 |   6 | 2020-07-13 14:24:08 |
	|  7 |   7 | 2020-07-13 14:24:11 |
	|  8 |   1 | 2020-07-13 14:41:43 |
	| 10 |   1 | 2020-07-13 14:41:43 |
	+----+-----+---------------------+
	8 rows in set (0.00 sec)


	begin;
	delete from t1 where ID=2;
	update t_20201023 set age=0;


	root@mysqldb 17:03:  [test_db]> show processlist;
	+-----+-----------------+---------------------+-------------+---------+------+-----------------------------+-----------------------------+
	| Id  | User            | Host                | db          | Command | Time | State                       | Info                        |
	+-----+-----------------+---------------------+-------------+---------+------+-----------------------------+-----------------------------+
	|   1 | event_scheduler | localhost           | NULL        | Daemon  |    0 | Waiting for next activation | NULL                        |
	| 376 | root            | 192.168.0.220:59296 | NULL        | Sleep   |  565 |                             | NULL                        |
	| 377 | root            | 192.168.0.220:59297 | niuniuh5_db | Sleep   |  564 |                             | NULL                        |
	| 378 | root            | 192.168.0.220:59298 | test_db     | Sleep   |  199 |                             | NULL                        |
	| 379 | root            | 192.168.0.220:59303 | test_db     | Sleep   |  306 |                             | NULL                        |
	| 381 | root            | 192.168.0.220:59304 | test_db     | Sleep   |  537 |                             | NULL                        |
	| 382 | root            | 192.168.0.220:59307 | test_db     | Sleep   |  525 |                             | NULL                        |
	| 383 | root            | 192.168.0.220:59308 | test_db     | Sleep   |  327 |                             | NULL                        |
	| 385 | root            | localhost           | NULL        | Sleep   |  101 |                             | NULL                        |
	| 386 | root            | localhost           | test_db     | Query   |    0 | starting                    | show processlist            |
	| 391 | root            | 192.168.0.220:59392 | test_db     | Sleep   |  199 |                             | NULL                        |
	| 396 | root            | localhost           | test_db     | Query   |    3 | updating                    | update t_20201023 set age=0 |
	+-----+-----------------+---------------------+-------------+---------+------+-----------------------------+-----------------------------+
	12 rows in set (0.00 sec)


	root@mysqldb 17:03:  [(none)]> kill 396;
	Query OK, 0 rows affected (0.00 sec)


	root@mysqldb 17:05:  [(none)]> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 6192960
					 trx_state: ROLLING BACK
				   trx_started: 2021-02-22 17:04:57
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 365534
		   trx_mysql_thread_id: 396
					 trx_query: update t_20201023 set age=0
		   trx_operation_state: rollback of SQL statement
			 trx_tables_in_use: 1
			 trx_tables_locked: 2
			  trx_lock_structs: 9379
		 trx_lock_memory_bytes: 909520
			   trx_rows_locked: 656284
			 trx_rows_modified: 356155
	   trx_concurrency_tickets: 0
		   trx_isolation_level: REPEATABLE READ
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	1 row in set (0.00 sec)


	root@mysqldb 17:05:  [test_db]> select * from t1;
	ERROR 2006 (HY000): MySQL server has gone away
	No connection. Trying to reconnect...
	Connection id:    404
	Current database: test_db

	+----+-----+---------------------+
	| ID | age | tEndTime            |
	+----+-----+---------------------+
	|  2 |   2 | 2020-07-13 14:23:57 |
	|  3 |   3 | 2020-07-13 14:24:00 |
	|  4 |   4 | 2020-07-13 14:24:03 |
	|  5 |   5 | 2020-07-13 14:24:05 |
	|  6 |   6 | 2020-07-13 14:24:08 |
	|  7 |   7 | 2020-07-13 14:24:11 |
	|  8 |   1 | 2020-07-13 14:41:43 |
	| 10 |   1 | 2020-07-13 14:41:43 |
	+----+-----+---------------------+
	8 rows in set (0.01 sec)


----------------------------------------------------------------------------------------------------------------------

kill query 1个大事务

	root@mysqldb 17:18:  [test_db]> update t_20201023 set age=0;


	root@mysqldb 17:10:  [test_db]> show processlist;
	+-----+-----------------+---------------------+-------------+---------+------+-----------------------------+-----------------------------+
	| Id  | User            | Host                | db          | Command | Time | State                       | Info                        |
	+-----+-----------------+---------------------+-------------+---------+------+-----------------------------+-----------------------------+
	|   1 | event_scheduler | localhost           | NULL        | Daemon  |   55 | Waiting for next activation | NULL                        |
	| 376 | root            | 192.168.0.220:59296 | NULL        | Sleep   | 1400 |                             | NULL                        |
	| 377 | root            | 192.168.0.220:59297 | niuniuh5_db | Sleep   | 1399 |                             | NULL                        |
	| 378 | root            | 192.168.0.220:59298 | test_db     | Sleep   | 1034 |                             | NULL                        |
	| 379 | root            | 192.168.0.220:59303 | test_db     | Sleep   | 1141 |                             | NULL                        |
	| 381 | root            | 192.168.0.220:59304 | test_db     | Sleep   | 1372 |                             | NULL                        |
	| 382 | root            | 192.168.0.220:59307 | test_db     | Sleep   | 1360 |                             | NULL                        |
	| 383 | root            | 192.168.0.220:59308 | test_db     | Sleep   | 1162 |                             | NULL                        |
	| 385 | root            | localhost           | NULL        | Sleep   |  516 |                             | NULL                        |
	| 386 | root            | localhost           | test_db     | Query   |    0 | starting                    | show processlist            |
	| 391 | root            | 192.168.0.220:59392 | test_db     | Sleep   | 1034 |                             | NULL                        |
	| 419 | root            | localhost           | test_db     | Query   |    2 | updating                    | update t_20201023 set age=0 |
	+-----+-----------------+---------------------+-------------+---------+------+-----------------------------+-----------------------------+
	12 rows in set (0.00 sec)

	root@mysqldb 17:18:  [test_db]> kill query 419;
	Query OK, 0 rows affected (0.00 sec)

	root@mysqldb 17:19:  [test_db]> show processlist;
	+-----+-----------------+---------------------+-------------+---------+------+-----------------------------+------------------+
	| Id  | User            | Host                | db          | Command | Time | State                       | Info             |
	+-----+-----------------+---------------------+-------------+---------+------+-----------------------------+------------------+
	|   1 | event_scheduler | localhost           | NULL        | Daemon  |   30 | Waiting for next activation | NULL             |
	| 376 | root            | 192.168.0.220:59296 | NULL        | Sleep   | 1495 |                             | NULL             |
	| 377 | root            | 192.168.0.220:59297 | niuniuh5_db | Sleep   | 1494 |                             | NULL             |
	| 378 | root            | 192.168.0.220:59298 | test_db     | Sleep   | 1129 |                             | NULL             |
	| 379 | root            | 192.168.0.220:59303 | test_db     | Sleep   | 1236 |                             | NULL             |
	| 381 | root            | 192.168.0.220:59304 | test_db     | Sleep   | 1467 |                             | NULL             |
	| 382 | root            | 192.168.0.220:59307 | test_db     | Sleep   | 1455 |                             | NULL             |
	| 383 | root            | 192.168.0.220:59308 | test_db     | Sleep   | 1257 |                             | NULL             |
	| 385 | root            | localhost           | NULL        | Sleep   |  611 |                             | NULL             |
	| 386 | root            | localhost           | test_db     | Query   |    0 | starting                    | show processlist |
	| 391 | root            | 192.168.0.220:59392 | test_db     | Sleep   | 1129 |                             | NULL             |
	| 419 | root            | localhost           | test_db     | Sleep   |   97 |                             | NULL             |
	+-----+-----------------+---------------------+-------------+---------+------+-----------------------------+------------------+
	12 rows in set (0.00 sec)


	root@mysqldb 17:18:  [test_db]> update t_20201023 set age=0;
	ERROR 1317 (70100): Query execution was interrupted

