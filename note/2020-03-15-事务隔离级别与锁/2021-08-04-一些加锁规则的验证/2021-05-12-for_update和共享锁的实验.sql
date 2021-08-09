
0. 行锁根据互斥的纬度可以分为 
1. 使用 LOCK IN SHARE MODE 共享锁的场景
2. 使用 FOR UPDATE 排他锁的场景
3. 小结
4. 思考
5. 相关参考
6. 小结

0. 行锁根据互斥的纬度可以分为
	共享锁：当读取当一行记录时为了防止别人修改则需要添加S锁
	排他锁：当修改一行记录时为了防止别人同时进行修改则需要添加X锁
	
1. 使用 LOCK IN SHARE MODE 共享锁的场景

	存在父子关系表即就是有外键关系的业务		
   比如用户对 ASIN(商品标识代码)进行分组;
   
   初始化表结构和数据
		DROP TABLE IF EXISTS `asin_group`;
		CREATE TABLE `asin_group` (
		  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
		  `name` varchar(20) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `idx_name` (`name`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4; 
		
		INSERT INTO `asin_group` VALUES ('1', '蓝牙耳机');

			
		DROP TABLE IF EXISTS `asin_info`;
		CREATE TABLE `asin_info` (
		  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
		  `group_id` bigint(20) DEFAULT NULL,
		  `asin` varchar(20) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY  `group_id` (`group_id`),
		  KEY `idx_asin` (`asin`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; 
		
		INSERT INTO `asin_info` VALUES ('1', '1', 'A003ZYF3LO');
		
	
	现象
		这时候要 新增一个ASIN并进行分组,  INSERT INTO `asin_info`(`group_id`,`asin`) VALUES ('1', 'B003ZYF3LO');
	
		但是 刚好在 插入这条记录的时候, 对应的 asin_group 被删除了, 在插入语句执行完成之后, 这时候数据会不一致;
	
		事务A                                                                        事务B
		start transaction;                                                            start transaction; 
																					  delete from asin_group where id=1;  
																					  delete from asin_info  where group_id=1;
		INSERT INTO `asin_info`(`group_id`,`asin`) VALUES ('1', 'B003ZYF3LO');
		(Blocked)																			  
																					  commit;
																								
		commit; 
		
		root@mysqldb 21:09:  [test_db]> select * from sys.innodb_lock_waits\G;


		*************************** 1. row ***************************
						wait_started: 2020-04-08 14:37:56
							wait_age: 00:00:13
					   wait_age_secs: 13
						locked_table: `test_db`.`asin_info`
						locked_index: group_id
						 locked_type: RECORD
					  waiting_trx_id: 281474977964014
				 waiting_trx_started: 2020-04-08 14:37:56
					 waiting_trx_age: 00:00:13
			 waiting_trx_rows_locked: 1
		   waiting_trx_rows_modified: 1
						 waiting_pid: 35
					   waiting_query: INSERT INTO `asin_info`(`group ... n`) VALUES ('1', 'B003ZYF3LO')
					 waiting_lock_id: 281474977964014:4840:4:1
				   waiting_lock_mode: X
					 blocking_trx_id: 281474977964005
						blocking_pid: 36
					  blocking_query: NULL
					blocking_lock_id: 281474977964005:4840:4:1
				  blocking_lock_mode: X
				blocking_trx_started: 2020-04-08 14:37:49
					blocking_trx_age: 00:00:20
			blocking_trx_rows_locked: 4
		  blocking_trx_rows_modified: 2
			 sql_kill_blocking_query: KILL QUERY 36
		sql_kill_blocking_connection: KILL 36
		1 row in set, 3 warnings (0.00 sec)


		查询数据
			root@mysqldb 14:38:  [test_db]> select * from asin_info;
			+----+----------+------------+
			| id | group_id | asin       |
			+----+----------+------------+
			|  2 |        1 | B003ZYF3LO |
			+----+----------+------------+
			1 row in set (0.00 sec)

			root@mysqldb 14:38:  [test_db]> select * from asin_group;
			Empty set (0.00 sec)
		
			##如果遇到这种场景的并发, 那么就很尴尬了, SESSION A插入的数据丢失了.

	所以解决办法就是:
		先查询 asin_group 对应的记录, 并加上共享锁, 防止别的事务对这一行记录做更新操作;
		然后正常进行插入;
		
		事务A                                                                        事务B
		start transaction;                                                            start transaction; 
		select * from asin_group where id=1 lock in share mode;							
																					  delete from asin_group where id=1;	
																					  ( 被阻塞 )
																					  ( 锁的范围: id=1行锁、排他锁, 排他锁跟SESSION A的共享锁互斥, 所以会阻塞;)
																					  delete from asin_info  where group_id=1;
																					  ( 一个事务内, 如果前面的SQL被阻塞, 那么该SQL之后的SQL都不会往下执行了;)
		INSERT INTO `asin_info`(`group_id`,`asin`) VALUES ('1', 'B003ZYF3LO');
																																						
		commit; 
																						
																					   #(Query OK)
																					   commit;
		
		查询数据
			root@mysqldb 14:36:  [test_db]> select * from asin_group;
			Empty set (0.00 sec)

			root@mysqldb 14:36:  [test_db]> select * from asin_info;
			Empty set (0.00 sec)


	
2. 使用 FOR UPDATE 排他锁的场景
	
	订单的商品数量: 下订单, 修改商品的库存; 其实主要是解决商品库存更新丢失的问题。
	mysql> select @@tx_isolation;
		+-----------------+
		| @@tx_isolation  |
		+-----------------+
		| READ-COMMITTED |
		+-----------------+
		1 row in set, 1 warning (0.00 se
	
	mysql> select * from product where name='mi8';
		+----+------+--------+
		| id | name | amount |
		+----+------+--------+
		|  1 | mi8  |     10 |
		+----+------+--------+
		1 row in set (0.00 sec)
	
	用户A下name='mi8'的订单数量为2,记为: $order_amount_a = 2
	用户B下name='mi8'的订单数量为1,记为: $order_amount_b = 1
	
	场景 1): 单纯地更新订单数量
	
		SESSION A                                                          SESSION B
		update product set amount=amount-$order_amount_a where name='mi8';
		
		
																		   update product set amount=amount-$order_amount_b where name='mi8';
																		   (Blocked; SESSION A未提交，排他锁跟排他锁互斥, 所以这里会阻塞,
																				被阻塞后, SESSION B获取不到这name='mi8'一行的行锁,
																				直到SESSION A释放后,才能获取到该行锁;
																			因为 update是当前读, 要读取已经提交的最新版本的行记录, 并对行记录加锁, 
																			当 SESSION A提交后, 就释放了name='mi', amount=8的行锁, 所以此时读取的是amount=8:
		commit;																update product set amount=7-$order_amount_b where name='mi8';)
		(result: amount=8)																	   
																			commit;
																			(result: amount=7)
		
	
	
	场景 2): 如果不加锁，会有什么问题
		SESSION A                                                          SESSION B
		start transaction;
																			start transaction;			
		$res = select amount from product where name='mi8';  #res=10
		
																		   $order_amount = 1
																		   $res = select amount from product where name='mi8'; #res=10;
																		   
		if $res>$order_amount
		  update product set amount=$res-$order_amount_a where name='mi8';
																		   if $res>$order_amount
																			 update product set amount=$res-$order_amount_b where name='mi8';
		commit;															   
																			(Blocked; SESSION A未提交，排他锁跟排他锁互斥, 所以这里会阻塞,
																			被阻塞后, SESSION B获取不到这name='mi8'一行的行锁,
																			直到SESSION A释放后,才能获取到该行锁.)
																			
							
		(result: amount=8)
																		   commit;
																		   (result: amount=9; 实际上这里返回的应该是7
																			所以SELECT 语句不加锁，会造成商品存在不一致。)
	这就是更新丢失的场景; 矛盾点所在：
		update语句的当前读，虽然能读取到SESSION A已经提交的最新版本的库存数量；
		但是这里的update语句的更新库存数量操作，是通过两个变量相减的。
	
	
	如果用的是  lock in share mode 共享锁, 可以看下会有什么问题:
														
	场景 3):
		SESSION A                                                          SESSION B
		begin;	
		select * from product where name='mi8' lock in share mode;
																			begin;	
																			select * from product where name='mi8' lock in share mode;	
		update product set amount=amount-1 where name='mi8';
		(blocked)
																			update product set amount=amount-1 where name='mi8';
																			(Deadlock found when trying to get lock; try restarting transaction)
		如果用的是  lock in share mode 共享锁, 会造成死锁, 语句回滚;
		(典型的BA-AB逻辑的死锁)
	
	场景 4):
		如果用的是 for update, 看下能不能解决在 lock in share mode共享锁下产生死锁的问题:
		SESSION A                                                          SESSION B
		begin;	
		amounts = select amount from product where name='mi8' for update;
																			begin;	
																			amounts = select * from product where name='mi8' for update;	
																			(Blocked; 排他锁跟排他锁互斥, 所以这里会阻塞,
																			被阻塞后, SESSION B获取不到这name='mi8'一行的行锁,
																			直到SESSION A释放后,才能获取到该行锁.)
																			
		update product set amount=amounts-1 where name='mi8';
																			update product set amount=amounts-1 where name='mi8';
		commit;
																			commit;
		如果用的是 for update, 操作同一行记录是以串行的方式执行，因此解决了死锁和丢失更新的问题;
	

3. 小结
	通过实际项目经验、实验, 知道了 排他锁和共享锁的应用场景:
	排他锁: 
		一般用在单个表存在并发更新的场景下, 解决数据不一致的问题; 
		目前生产环境上有在用，用于 玩家积分 的场景上。
	共享锁:
		一般用在多个表存在业务关系的场景下, 解决数据不一致的问题;
	加锁设计，也是一门学问。
	
	
4. 思考
	1. 一个事务内，给行记录加上for update之后, 接下来更新这一行，是否会被阻塞？

		DROP TABLE IF EXISTS `product`;
		CREATE TABLE `product` (
		  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
		  `name` varchar(20) DEFAULT NULL,
		  `amount` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `idx_name` (`name`)
		) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

		-- ----------------------------
		-- Records of product
		-- ----------------------------
		INSERT INTO `product` VALUES ('1', 'mi8', '10');


		实验如下:
		begin;

		select * from product where name='mi8' for update;
		+----+------+--------+
		| id | name | amount |
		+----+------+--------+
		|  1 | mi8  |     10 |
		+----+------+--------+
		1 row in set (0.00 sec)

		update product set amount=amount-1 where name='mi8';
		Query OK, 1 row affected (0.00 sec)
		Rows matched: 1  Changed: 1  Warnings: 0

		
	答: 不会被阻塞, for update是指要修改一行数据, 防止别的事务也进行修改, 需要加上 X锁;
	
	
	
5. 相关参考
	https://www.cnblogs.com/liaoweipeng/p/7615959.html             MySQL的排他锁和共享锁
	https://dev.mysql.com/doc/refman/5.7/en/innodb-locks-set.html
	
	

	
	