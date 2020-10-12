

### 这里可以用 markdown 格式来写

1. 基本概念
2. 可见性判断规则
3. 事务执行流程
4. 通过人肉分析可见性规则
	4.1 事务 A 此时的视图数组
	4.2 画出跟事务A查询逻辑有关的操作
	4.3 事务 A 的S3时刻的查询结果为 (1,1,'a') 分析
	4.4 构建行的多版本回溯查找数据
	4.5 结论	
5. 通过结论分析可见性规则
6. 小结
7. 相关参考					   


1. 基本概念

	
2. 可见性判断规则

	   
	
3. 事务执行流程

	例如下面中id=1的记录存在三个版本，在Repeatable-Read下select * from t1 查询返回的是第一个老的版本(1,1,'a')。	

		session A            session B                              备注
							 insert into t1 values(1,1,'a');        T1: row trx_id=1;
		begin;
		select * from t1;                                           S1时刻: 结果: (1,1,'a')

							 update t1 set c3='b' where id=1;       T2: row trx_id=3
							 
		select * from t1;                                           S2时刻: 结果: (1,1,'a')

							 update t1 set c3='c' where id=1;       T3: row trx_id=5

		select * from t1;									        S3时刻: 结果: (1,1,'a')
		
	
	--这个例子来源：https://mp.weixin.qq.com/s/UxawgHGembMKK2lA33ZQDA   InnoDB MVCC 详解    # 腾讯数据库技术
	

4. 通过人肉分析可见性规则
	
	4.1 事务 A 此时的视图数组
	
		1.1 事务 A 开始前, 系统里面没有活跃事务, 即 m_ids 为 NULL
		
		1.2 事务 B 的版本号: 
			T1: row trx_id=1;
			T2: row trx_id=3;
			T3: row trx_id=5;
				
		1.3 read view:
			
			事务 A 的 S1时刻: [null]，当前系统已经创建过的最大事务ID为1， 所以高水位为 2 即 max_trx_id=2，低水位m_up_limit_id/min_trx_id为 0
			事务 A 的 S2时刻: [null]，使用的是 S1时刻 的视图，高水位为 2  即 max_trx_id=2，低水位m_up_limit_id/min_trx_id为 0
			事务 A 的 S3时刻: [null]，使用的是 S1时刻 的视图，高水位为 2  即 max_trx_id=2，低水位m_up_limit_id/min_trx_id为 0
		
			m_up_limit_id/min_trx_id = 0
			m_low_limit_id/max_trx_id = 2
			
		
		
	4.2 画出跟事务A查询逻辑有关的操作
	
		事务A 				事务B
							T1 时刻              历史版本: row trx_id=1, (1,1,'a')
											
		S1 时刻	
		[null]
							T2 时刻              历史版本: row trx_id=3, (1,1,'b') 							
											 
		S2 时刻 
		[null]
							T3 时刻              当前版本: row trx_id=5, (1,1,'c')
		S3 时刻             
		[null]
		
	
	4.3 事务 A 的S3时刻的查询结果为 (1,1,'a') 分析
	
		1. 事务B:
			T2 时刻, 把数据从  (1,1,'a') 改为了 (1,1,'b') , 这个数据的最新版本为 row trx_id = 3, 而 row trx_id=1 成了历史版本;
			T3 时刻, 把数据从  (1,1,'b') 改为了 (1,1,'c') , 这个数据的最新版本为 row trx_id = 5, 而 row trx_id=3 成了历史版本;
		
		2. 事务 A 的S3时刻的查询结果为 (1,1,'a') 分析:
			
			S3 时刻的视图数组是 [null], 读数据都是从当前版本读起的
			
			首先找到最新的记录 (1,1,'c'), 判断 row trx_id = 5 比高水位(m_low_limit_id/max_trx_i=2)大, 不可见
			然后通过 roll_ptr 构建上一个历史版本(1,1,'b'),  判断 row trx_id = 3 比高水位(m_low_limit_id/max_trx_i=2)大, 不可见
			再往前找, 通过 rool_ptr 构建出 (1,1,'a'), 它的 row trx_id = 1, 比高水位(m_low_limit_id/max_trx_i=2)小, 比 低水位(m_up_limit_id/min_trx_id = 0) 大，
			说明处于 `m_ids`范围内，但是不在 read view 中，所以可见。
			
			所以最后返回(1,1,’a’)
		
		
	4.4 构建行的多版本回溯查找数据
		
		update 是原地更新的, 所以 undo 存储的是 键值和老值, 所以 undo 不需要存储 c2 的值.
		
		1. insert into t1 values(1,1,'a');
				
			RowID   DB_TRX_ID   DB_ROLL_PTR   c1    c3
			1       1           NULL          1     'a'
			
			
		2. update t1 set c3='b' where id=1;; 

			当前最新版本的行数据:
				RowID   DB_TRX_ID   DB_ROLL_PTR   c1    c3
				1       3           1         	  1     'b'	

			undo log(旧版本的数据): 
				RowID   DB_TRX_ID   DB_ROLL_PTR   c1    c3
				1       1           NULL          1     'a'	
			
		3. update t1 set c3='c' where id=1; 

			当前最新版本的行数据:
				T3:
					RowID   DB_TRX_ID   DB_ROLL_PTR   c1     c3        
					1       5           3        	   1     'c'	

			undo log(旧版本的数据): 
				T2:
					RowID   DB_TRX_ID   DB_ROLL_PTR   c1     c3
					1       3           1         	   1     'b'
				T1:	
					RowID   DB_TRX_ID   DB_ROLL_PTR   c1     c3
					1       1           NULL           1     'a'	
			
		4. 在cluster index中，最新的版本记录为 T3(1,5,roll_ptr,1,'c') 其中5为事务id，数据就在page中；  # 理解了，因为当前版本的记录是在page中。
			上一个版本为 T2(1,3,roll_ptr,1,'b'), 可通过 T3(1,5,roll_ptr,1,'c') 上 roll_ptr 指向的undo记录构造出来；
			而最老的版本为 T1(1,1,roll_ptr,1,'a'), 可通过 T2(1,3,roll_ptr,1,'b') 上 roll_ptr 指向的undo记录构造出来。
	
	4.5 结论
		1. 如果当前最新的数据版本不可见, 会根据 DB_ROLL_PTR 构建并回溯查询历史版本,  直到找到对应可见的版本; 
		2. RR 隔离级别的 read view 是事务开始之后的第一个 SQL 申请，之后事务内的其他 SQL 都使用该 read view。
		3. 通过 分析实验结果的过程 来验证原理.
		
5. 通过结论分析可见性规则
		
	
	1. 一个数据版本， 对于一个事务视图来说， 除了自己的更新总是可见以外， 有三种情况：
		1. 版本未提交， 不可见；
		2. 版本已提交：
			2.1：是在视图创建之后提交的，不可见；
			2.2：是在视图创建之前提交的，可见。					   
	2. 这个规则对 RR和RC隔离级别都生效。
		
	3. 事务 A 的S3时刻 的返回结果分析:

		在 S1 阶段 是正式启动一个事务, 并且创建 read view; 
		虽然 T3 和 T2 的版本已经提交, 但是是在  视图创建之后提交的，所以不可见.
		T1 版本 在 视图创建之前提交, 符合 2.1, 所以可见
	

6. 小结：	
	6.1 MVCC实现原理
		1、通过 read view 判断行记录是否可见	
		2、读数据都是从当前版本开始读取的, 如果当前版本不可见, 通过 undo 构建历史版本, 通过 DB_ROLL_PTR 回溯查找数据历史版本, 直到找到对应可见的版本.
		
	6.2 MVCC(Mutil-Version Concurrency Control):	
		基本概念
			同一行记录在系统中可以存在多个版本，由此带来的并发控制 , 这就是数据库的多版本并发控制（MVCC）。
			基于 read view 也就是一致性视图 和 回滚段的 undo 信息实现。
		详细概念：
			InnoDB多版本数据是通过delete mark（删除标记）的行数据和回滚段中的undo信息组成的。
			
		
		MVCC 由 read view + 行记录的多版本构成, 行记录的多版本包括 delete mark(打了删除标记)的行记录和回滚段中的undo信息, 由此带来的并发控制, 被称为多版本并发控制.
		
		cluster index的历史版本在 undo日志 中或为 delete mark 的记录(没毛病, 理解了)，secondary index的历史版本是delete mark的记录。
	
		Undo记录中存储的是老版本数据，当一个旧的事务需要读取数据时，为了能读取到老版本的数据，需要顺着undo链找到满足其可见性的记录。
		当版本链很长时，通常可以认为这是个比较耗时的操作.

	
		undo log是真实存在的, 但是用于构建MVCC的行记录的多版本并不是物理上真实存在的，而是每次需要的时候根据当前版本和 undo log 计算出来的。   # 这里需要确认.
	
	
	--通过案例分析，不断更新的理论知识、不断更新自己的认知。
	


7. 相关参考					   
	https://mp.weixin.qq.com/s/UxawgHGembMKK2lA33ZQDA     InnoDB MVCC 详解
		学习人家是怎么分析的.
		之后 根据 MySQL 实战45讲的第8节, 看看是如何构建旧版本的.
			
	https://mp.weixin.qq.com/s/UxawgHGembMKK2lA33ZQDA     InnoDB MVCC 详解
	https://mp.weixin.qq.com/s/R3yuitWpHHGWxsUcE0qIRQ     InnoDB并发如此高，原因竟然在这？



8. 思考
	m_up_limit_id: 2，这里理解不对吧，应该为 m_up_limit_id: 0；
	后期有时间的话，反馈一下。
	
	

