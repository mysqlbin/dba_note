
1. MySQL 5.7-5.7.21版本的并行复制策略
2. writeset 是什么
3. writeset 对 last commit 的处理方式
4. writeset的历史MAP
5. writeset的并行复制对 last commit 的处理流程
6. writeset_session的方式
7. binlog_transaction_dependency_history_size
8. 为什么同一个session执行的事务也能生成同样的 last commit
9. writeset并行复制策略的约束
10. 小结


1. MySQL 5.7-5.7.21版本的并行复制策略
	1. 同时处于 prepare 状态的事务，在备库执行时是可以并行的；
	2. 处于 prepare 状态的事务，与处于 commit 状态的事务之间，在备库执行时也是可以并行的。

	3. 具体实现机制：
       1. 在一组里面一起提交的事务，有一个相同的 commit_id 即 last commit，下一组就是 commit_id+1；
       2. commit_id 直接写到 binlog 里面；     
       3. 传到备库应用的时候，相同 commit_id 的事务分发到多个 worker 执行；
       4. 这一组全部执行完成后，coordinator 再去取下一批。
	   5. coordinator：作为分发器，负责 读取中转日志(relay log)和分发事务给不同的worker; 
	  
2. writeset 是什么
	用于存储需要更新的行记录的 hash 值 的集合 即 集合的每一个元素都是 hash 值
	对于事务涉及更新的每一行，计算出这一行的 hash 值，组成集合 writeset；如果两个事务没有操作相同的行，也就是说它们的 writeset 没有交集，就可以并行。
	hash 值 是通过 更新的每一行记录 通过 hash 算法计算得来。
	hash 值的计算方式：
		当然为了唯一标识，这个 hash 值是通过 库名 + 表名 + 索引名 + 值 计算出来的。如果一个表上除了有主键索引外，还有其他唯一索引，那么对于每个唯一索引，insert 语句对应的 writeset 就要多增加一个 hash 值。
	
3. writeset 对 last commit 的处理方式
	基于 writeset 的并行复制方式只是在 order_commit 的基础上对 last_commit 做更一步处理,并不影响原有的 order_commit 的逻辑,因此
	如果要回退到基于 order_commit 的并行复制则非常方便. 

4. writeset的历史MAP
	表示行数据的 hash 值和 seq number 的一个 MAP, 存储在内存中
	在内存中保存一份历史MAP
		如果要降低 last commit 的值需要通过对事务的 writeset 和 writeset的历史MAP进行比较, 看看是否冲突才能决定降低为什么值, 因此必须要在内存保存一份这样的一个历史MAP才行.
		如果有冲突, 就把 历史MAP 中的 seq number 赋值给该事务的 last commit 
		如果没有冲突即不存在的历史MAP中, 就把 行数据的 hash 值 和 seq number 插入到 历史MAP 中. 
			
	历史MAP包含两个元素:
		1. writeset 的 hash 值
		2. 最新一次本行数据修改事务的 seq number    # 需要理解为什么需要存储 最新一次本行数据修改事务的 seq number;  原因： 用来赋值给 last commit
		
	m_writeset_history_start	
		在内存中还维护一个叫做 m_writeset_history_start 的值, 用于记录 writeset 的历史 MAP 中最早事务(最老)的 seq number
		如果 writeset 的历史MAP满了就会清理这个历史MAP然后将本事务的 seq number  写入 m_writeset_history_start, 作为最早的 seq number
		对于事务 last commit 的值的修改总是从这个值开始然后进行比较判断修改的, 如果在 writeset的历史MAP中没有找到冲突那么直接设置 last commit 为这个 m_writeset_history_start 值.

5. writeset的并行复制对降低 last commit 的处理流程
	
	在内存中保存一份历史MAP:
		如果要降低 last commit 的值需要通过对事务的 writeset 和 writeset的历史MAP进行比较, 看看是否冲突才能决定降低为什么值, 因此必须要在内存保存一份这样的一个历史MAP才行.
		
		如果有冲突, 就把 历史MAP 中的 seq number 赋值给该事务的 last commit 
		如果没有冲突即不存在的历史MAP中, 就把 行数据的 hash 值 和 seq number 插入到 历史MAP 中. 
		
	假设如下
		1. order_commit 下生成的 last commit = 125, seq number = 130			
		2. 本事务修改(插入)了4条数据，分别使用 row1、row7、row6、row10 代表
		3. 表有主键但是没有唯一键，本例使用行数据的二进制格式的 hash 值 来做分析
		
	初始化情况如下
		1. order_commit 下生成的 last commit = 125, seq number = 130	 
		2. 本次事务的 writeset: row1.hashval、row7.hashval、row6.hashval、row10.hashval
		3. writeset 的历史 MAP
			1. m_writeset_history_start = 100 代表最老的 seq number
			2. 
				row1.hashval seq number = 120
				row2.hashval seq number = 110
				row3.hashval seq number = 112
				row4.hashval seq number = 103
				row5.hashval seq number = 107
				row6.hashval seq number = 105
				row7.hashval seq number = 114
				row8.hashval seq number = 120
				.............................
	
	对降低 last commit 的处理流程
		1. 对于事务 last commit 的值的修改总是从 m_writeset_history_start 这个值开始然后进行比较判断修改的
			因此，第一步 设置 last commit 为 m_writeset_history_start 的值也就是 100
			
		2. 第二步 row1.hashval 在 writeset 历史 MAP 中查找，找到冲突的 row1.hashval，需要做以下操作：
			修改历史MAP中这行数据 seq number = 130，设置本次事务的 last commit = 120
			
		3. 第三步 row7.hashval 在 writeset 历史 MAP 中查找，找到冲突的 row7.hashval，需要做以下操作：
			修改历史MAP中这行数据 seq number = 130
			由于 历史MAP中对应的 seq number = 114, 小于 120 不做更改，last commit 依旧为 120
			
		4. 第四步 row6.hashval 在 writeset 历史 MAP 中查找，找到冲突的 row7.hashval，需要做以下操作：
			修改历史MAP中这行数据 seq number = 130
			由于 历史MAP中对应的 seq number = 105, 小于 120 不做更改，last commit 依旧为 120	
		
		5. 第五步 row10.hashval 在 writeset 历史 MAP 中查找，没有找到冲突的行，需要做以下操作：
			将这一行插入到 writeset 历史MAP 中查找（需要判断是否导致 历史MAP 占满， 如果占满则不需要插入，后面随即要清理掉，然后将本事务的 seq number = 130 写入 m_writeset_history_start, 作为最早的 seq number ）
			将 row10.hashval 和 seq number = 130 插入到 writeset 历史MAP 中。
			
		6. 至此，整个过程结束。可以看到，last commit 由以前的 125 降低为 120， 目的达到了。并且可以看出 writeset的历史MAP 相当于保存了一段时间以来修改行的快照，如果保证本次事务修改的数据在这段时间内没有冲突，那么显然是可以在从库并行执行的。

	降低 last commit 如下
	
		1. writeset 更改了 last commit： last commit = 120, seq number = 130	 
		2. writeset 的历史 MAP
			1. m_writeset_history_start = 100 代表最老的 seq number
			2. 
				row1.hashval seq number = 130
				row2.hashval seq number = 110
				row3.hashval seq number = 112
				row4.hashval seq number = 103
				row5.hashval seq number = 107
				row6.hashval seq number = 130
				row7.hashval seq number = 130
				row8.hashval seq number = 120
				.............................
				row10.hashval seq number = 130
		
	小结：
		本案例的 writeset 的 历史MAP 的 seq number 赋值给本次事务的 last commit，从而达到降低 last commit 的目的 , 本次事务生成的 seq number 赋值给历史MAP的 seq number 即 修改历史MAP中这行数据为 seq number = 130 。 
	
6. writeset_session的方式
	在 writeset 的基础上继续处理, 表示 同一个 session 的事务不允许在从库并行回放；
	是在 WRITESET 的基础上多了一个约束；在主库上同一个线程先后执行的两个事务，在备库执行的时候，要保证相同的先后顺序。 
	意味着同一个session 执行的事务不能生成同样的 last commit.
	
	
7. binlog_transaction_dependency_history_size 
	默认值为 25000， 最小值为 1， 最大值为 1000000
	表示 writeset 历史MAP中元素的个数
	通过前面的分析得到 writeset 生成过程中修改一行数据可能会生成多个 hash 值，因此这个值还不能完全等待于修改的行数，可以理解为如下：
		binlog_transaction_dependency_history_size / 2 = 修改的行数 * （1+唯一键个数）
	该参数带来收益和问题：
		如果这个值越大，那么在 历史MAP能存储的元素越多，生成的 last commit 就可能更加精确（更加小），从库并发的效率也就可能越高；
		但是设置越大相应的内存需求也就越高了。

	相关参考
		https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_history_size
	
8. 为什么同一个session执行的事务也能生成同样的 last commit
	由于writeset 的历史MAP 的存在，只要这些事务修改的行没有冲突，也就是主键/唯一键不相同，那么在基于 writeset 的并行复制方式中就可以存在这种现象。
	
9. writeset并行复制策略的约束
	对于 表上没主键或者没有唯一键 和 有外键约束 的场景，WRITESET 策略也是没法并行的，也会暂时退化为单线程模型。

	
10. 小结
	基于writeset的并行复制策略的优点：
		1.节省了很多计算量： writeset 是在主库生成后直接写入到 binlog 里面的，这样在备库执行的时候，不需要解析 binlog 内容（event 里的行数据）
        2.更省内存：不需要把整个事务的 binlog 都扫一遍才能决定分发到哪个 worker
        3.由于备库的分发策略不依赖于 binlog 内容，所以 binlog 是 statement 格式也是可以的。
        4. 因此，MySQL 5.7.22 的并行复制策略在通用性上还是有保证的。
	
	缺点：
		1. writeset 中 每个 hash 值都需要和 writeset 的历史MAP进行比较
		2. writeset 需要额外的内存空间
		3. writeset 的历史MAP也需要额外的内存空间	
		