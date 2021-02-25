

1. RR隔离级别的实现
2. RC隔离级别的实现
3. 小结
4. 一个数据无法修改的场景


1. RR隔离级别的实现
	mysql> select @@tx_isolation;
	+-----------------+
	| @@tx_isolation  |
	+-----------------+
	| REPEATABLE-READ |
	+-----------------+
	1 row in set, 1 warning (0.00 sec)

	mysql> show global variables like 'tx_isolation';
	+---------------+-----------------+
	| Variable_name | Value           |
	+---------------+-----------------+
	| tx_isolation  | REPEATABLE-READ |
	+---------------+-----------------+
	1 row in set (0.00 sec)


	root@mysqldb 23:26:  [db1]> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)



	CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `k` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB;

	insert into t(id, k) values(1,1),(2,2);

	事务的执行次序
		session A										session B										session C
		start transaction with consistent snapshot; 
						
														start transaction with consistent snapshot; 	
																										update t set k=k+1 where id=1; 
														update t set k=k+1 where id=1;
														select k from t where id=1;

		select k from t where id=1;
		commit;

	
	假设：
		1. 事务 A 开始前，系统里面只有一个活跃事务 ID 是 99；
		2. 事务 A、B、C 的版本号分别是 100、101、102，且当前系统里只有这四个事务；
		3. 三个事务开始前，(1,1）这一行数据的 row trx_id 是 90。
		4. 视图数组：
			事务 A ： [99,100]
			事务 B ： [99,100,101]
			事务 C ： [99,100,101,102]
			
			说明了视图数组包含了当前事务的版本号;
			
		画出跟事务A查询逻辑有着的操作:
																							备注(版本号)
			事务A(version=100)	 
			[99, 100]		
								事务B(version=101)     
								[99,100,101]		
														事务C(version=102)
														[99,100,101,102]
																							历史版本2: row trx_id = 90,  k = 1  
																			 
														update t set k=k+1 where id=1;      历史版本1: row trx_id = 102, k = 2
													
								update t set k=k+1 where id=1;              				当前版本:  row trx_id = 101, k = 3						
								
			get k
			[99, 100]


		1. 第一个有效更新是事务 C，把数据从 (1,1) 改成了 (1,2)
			这个数据的最新版本的 row trx_id 是 102，而 90 这个版本已经成为了历史版本
		   
		2. 第二个有效更新是事务 B，把数据从 (1,2) 改成了 (1,3)
			这个数据的最新版本的 row trx_id 是 101，而 102 又成为了历史版本。
		   
		3. 在事务 A 查询的时候，其实事务 B 还没有提交，但是它生成的 (1,3) 这个版本已经变成当前版本了， 但这个版本对事务 A 必须是不可见的，否则就变成脏读了。  
			最后更新的事务生成的版本会变成当前版本
			
		4. 事务 A 的查询结果为1的分析：
			
			事务 A 的视图数组是 [99,100], 读数据都是从当前版本读起的
			
			找到 (1,3) 的时候，判断出 row trx_id=101，比高水位（100）大，处于红色区域，不可见；
			
			接着，找到上一个历史版本，一看 row trx_id=102，比高水位（100）大，处于红色区域，不可见；
			
			再往前找，终于找到了（1,1)，它的 row trx_id=90，比低水位（99）小，处于绿色区域，可见。
			
			所以事务A的查询结果为1
			
			验证了一个理论: 数据版本的可见性判断是根据行记录版本的事务ID跟 read view 中的活跃事务列表做比较.  --真正意义上理解了，理论+实践，同时通过实践理解原理/理论。
							一行记录如果有多个版本，那么可能就需要比较多次
										
			
		归纳：一个事务只承认自身更新的数据版本以及视图创建之前已经提交的数据版本     # 总结得可以.
		
2. RC隔离级别的实现		
	
	mysql> show global variables like 'tx_isolation';
	+---------------+----------------+
	| Variable_name | Value          |
	+---------------+----------------+
	| tx_isolation  | READ-COMMITTED |
	+---------------+----------------+
	1 row in set (0.00 sec)


	CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `k` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB;

	insert into t(id, k) values(1,1),(2,2);


	session A										session B										session C
	start transaction with consistent snapshot; 
	
					
													start transaction with consistent snapshot; 
																		
																									update t set k=k+1 where id=1; 
													update t set k=k+1 where id=1;
													select k from t where id=1;

	select k from t where id=1;
	commit;
		
	
	在 RC 隔离级别下， start transaction with consistent snapshot;  相当是  begin; 或者 start transaction;
		--如果是这样的话，那么这个案例就有问题了，正常的情况下是： session C 的事务ID是最小的。
		--又感觉没有问题。
		
	假设：
		1. 事务 A 开始前，系统里面只有一个活跃事务 ID 是 99；
		2. 事务 A、B、C 的版本号分别是 100、101、102，且当前系统里只有这四个事务；
		3. 三个事务开始前，(1,1）这一行数据的 row trx_id 是 90。
		4. 视图数组：
			事务 A ： [99, 100, 101]
			事务 B ： [99, 101]
			事务 C ： [99, 102]
			说明了视图数组包含了当前事务的版本号;
			
		画出跟事务A查询逻辑有关的操作:
		
		事务A(version=100)	 
		begin;			
							事务B(version=101)     
							begin;		
														事务C(version=102)
														视图数组: [99, 102]
																				 历史版本2: row trx_id = 90,  k = 1  
																		 
														set k=k+1                历史版本1: row trx_id = 102, k = 2
												
												
							update t set k=k+1 where id=1;               		 当前版本:  row trx_id = 101, k = 3						
							get k
							视图数组: [99, 101]
								
		get k
		
		视图数组：[99, 100, 101]
		
		
							commit;
							
		事务 A 的查询结果为2的分析
			
			1. 第一个有效更新是事务 C，把数据从 (1,1) 改成了 (1,2)
				这个数据的最新版本的 row trx_id 是 102，而 90 这个版本已经成为了历史版本
			   
			2. 第二个有效更新是事务 B，把数据从 (1,2) 改成了 (1,3)
				这个数据的最新版本的 row trx_id 是 101，而 102 又成为了历史版本。
			   
			3. 在事务 A 查询的时候，其实事务 B 还没有提交，但是它生成的 (1,3) 这个版本已经变成当前版本了， 但这个版本对事务 A 必须是不可见的，否则就变成脏读了。  
				最后更新的事务生成的版本会变成当前版本
				
			4. 事务 A 的查询结果为2的分析：
				
				事务 A 的 read view 是 [99, 100, 101] 读数据都是从当前版本读起的
				
				找到 (1,3) 的时候，判断出 row trx_id=101，比高水位（103）小，在 read view中, 但是这个版本是由还没提交的事务生成的, 处于黄色区域即3(a), 不可见;
				
				-- 找到 (1,3) 的时候，判断出 row trx_id=101，等于 高水位（101），在 read view中, 但是这个版本是由还没提交的事务生成的, 处于黄色区域即3(a), 不可见;


				接着，找到上一个历史版本，一看 row trx_id=102，发现 在 read view(m_ids) 的范围内, 不在 read view 中: 
				
					[比高水位(m_low_limit_id=103)小, 比低水位(m_up_limit_id=99)大] , trx_id=102 处于 `m_ids`列表范围内并且不在`m_ids`列表中，所以记录可见； 
					
					-- [比高水位(m_low_limit_id=101)大, 比低水位(m_up_limit_id=99)大] , 比高水位大，不可见。
					
					因此，高水位的定义是当前系统已经创建过的最大事务ID加1.
					
					
				所以事务A的查询结果为 k = 2;
				
				验证了一个理论: 数据版本的可见性判断是根据行记录版本的事务ID跟 read view 中的活跃事务列表做比较.
								而数据版本的可见性规则，就是基于数据的 row trx_id 和这个一致性视图的对比结果得到的。
				
				-- 这个案例很有借鉴意义。
				
		事务 B 的查询结果为3的分析:
			
			1. 第一个有效更新是事务 C，把数据从 (1,1) 改成了 (1,2)
				这个数据的最新版本的 row trx_id 是 102，而 90 这个版本已经成为了历史版本
			   
			2. 第二个有效更新是事务 B，把数据从 (1,2) 改成了 (1,3)
				这个数据的最新版本的 row trx_id 是 101，而 102 又成为了历史版本
			
			3. 事务 B 还没有提交，但是它生成的 (1,3) 这个版本已经变成当前版本了
				
			4. 事务 B 的查询结果为3的分析：
			
				事务 B 的 read view 是 [99, 101], 读数据都是从当前版本读起的
				
				从当前版本找到 (1,3) 的时候，判断出 row trx_id=101，比高水位（103）小，虽然 这个版本是由还没提交的事务生成的, 但是 事务内的更新对自己可见
				
				(当记录的 DATA_TRX_ID（数据版本ID） 和 事务创建者的 TRX_ID 一样，记录可见；)
				
				所以 事务 B 的查询结果为3.
				
				
		
3. 小结	
	多分析几个例子, 就熟悉了.
	明白了如何基于MVCC实现可重复读和读已提交事务隔离。
	数据版本的可见性规则，就是基于行数据的 row trx_id (可能有多个)和这个一致性视图的对比结果得到的。
	如果当前最新的数据版本不可见, 会根据 DB_ROLL_PTR 构建并回溯查询历史版本,  直到找到对应可见的版本; 
	高水位ID并不在活跃的事务ID列表中。
	
	
	
4. 一个数据无法修改的场景

	mysql> select @@tx_isolation;
	+-----------------+
	| @@tx_isolation  |
	+-----------------+
	| REPEATABLE-READ |
	+-----------------+
	1 row in set, 1 warning (0.00 sec)

	mysql> select @@global.tx_isolation;
	+-----------------------+
	| @@global.tx_isolation |
	+-----------------------+
	| REPEATABLE-READ       |
	+-----------------------+
	1 row in set, 1 warning (0.00 sec)
	
	
	CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `c` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB;
	insert into t(id, c) values(1,1),(2,2),(3,3),(4,4);	
	
	流程
		事务 A                                  	事务B 
		
		begin;	
		
		SELECT * FROM t;
													update t  set  c=c+1;
		UPDATE t SET c=0 WHERE id=c;

		SELECT * FROM t;
	
	实际过程
		
		mysql> begin;
		Query OK, 0 rows affected (0.00 sec)
				
		mysql> SELECT * FROM t;
		+----+------+
		| id | c    |
		+----+------+
		|  1 |    1 |
		|  2 |    2 |
		|  3 |    3 |
		|  4 |    4 |
		+----+------+
		4 rows in set (0.00 sec)

													mysql> update t  set  c=c+1;
													Query OK, 4 rows affected (0.01 sec)
													Rows matched: 4  Changed: 4  Warnings: 0

													mysql> SELECT * FROM t;
													+----+------+
													| id | c    |
													+----+------+
													|  1 |    2 |
													|  2 |    3 |
													|  3 |    4 |
													|  4 |    5 |
													+----+------+

		mysql> UPDATE t SET c=0 WHERE id=c;
		Query OK, 0 rows affected (0.00 sec)
		Rows matched: 0  Changed: 0  Warnings: 0

		mysql> SELECT * FROM t;
		+----+------+
		| id | c    |
		+----+------+
		|  1 |    1 |
		|  2 |    2 |
		|  3 |    3 |
		|  4 |    4 |
		+----+------+
		4 rows in set (0.00 sec)
	
	数据无法修改的分析:
		UPDATE t SET c=0 WHERE id=c;  语句是当前读, 要读取已经提交的最新版本, 事务B已经把数据给修改了, 所以事务A的update语句是在事务B的update语句完成之后进行操作的.
		
		
	-------------------------------------------------------------------------------------------------------------------------------------------------	
	session  A 看的内容也是能够复现我截图的效果的。这个 session B’启动的事务比 A 要早，其实是上期我们描述事务版本的可见性规则时留的彩蛋，因为规则里还有一个"活跃事务的判断"	

	
	用新的方式来分析 session B’的更新为什么对 session A 不可见就是：在 session A 视图数组创建的瞬间，session B’是活跃的，属于“版本未提交，不可见”这种情况。

	在 RR 隔离级别，如果 A 事务在 B 事务创建 read view 之前开始的，那么 B 事务里面的 SQL 是不能看到 A 事务执行的修改的。因此还有一条规则：如果记录对应的 DATA_TRX_ID 在 read view 的 trx_ids 里面，那么该记录也是不可见的。


	这个实际场景还挺常见——所谓的“乐观锁”。
		时常我们会基于version字段对row进行cas式的更新，类似update ...set ... where id = xxx and version = xxx。
		如果version被其他事务抢先更新，则在自己事务中更新失败，trx_id没有变成自身事务的id，同一个事务中再次select还是旧值，就会出现“明明值没变可就是更新不了”的“异象”（anomaly）。
		解决方案就是每次cas更新不管成功失败，结束当前事务。如果失败则重新起一个事务进行查询更新。
		记得某期给老师留言提到了，似乎只有MySQL是在一致性视图下采用这种宽松的update机制。
		也许是考虑易用性吧。其他数据库大多在内部实现cas，只是失败后下一步动作有区别。

		
		作者回复: 早

	赞

	置顶了

	明天课后问题时间直接指针引用了哈😄

	补充一下：上面说的“如果失败就重新起一个事务”，里面判断是否成功的标准是 affected_rows 是不是等于预期值。
	比如我们这个例子里面预期值本来是4，当然实际业务中这种语句一般是匹配唯一主键，所以预期住值一般是1。]





