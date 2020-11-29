
1. read view的基本概念和实现
2. read view 中主要包含4个比较重要的内容
3. 可见性判断规则


1. read view的基本概念和实现

	read view是一致性视图, 它的实现逻辑是: InnoDB 为每个事务构造了一个数组，用来保存这个事务启动瞬间，当前正在 活跃 的所有事务 ID
	活跃的定义: 已经启动但是没有提交的事务
	
	低水位和高水位：
        低水位: 数组里面事务 ID 的最小值记为低水位  对应   m_up_limit_id/min_trx_id  
        高水位: 当前系统里面已经创建过的事务ID 的最大值加 1 记为高水位  对应  m_low_limit_id/max_trx_id
		
	这个视图数组和高水位，就组成了当前事务的一致性视图即read-view。

	而数据版本的可见性规则，就是基于数据的 row trx_id 和这个一致性视图的对比结果得到的。
	
2. read view 中主要包含4个比较重要的内容
	
	1. m_ids ：表示在生成ReadView时当前系统中活跃的读写事务的事务id列表。

	2. min_trx_id ：表示在生成ReadView时当前系统中活跃的读写事务中最小的事务id，也就是m_ids中的最小值。
		
		对应低水位即数组里面事务ID的最小值即 m_up_limit_id/min_trx_id；
		
	3. max_trx_id ：表示生成ReadView时系统中应该分配给下一个事务的id值。

		小贴士： 注意max_trx_id并不是m_ids中的最大值，事务id是递增分配的。比方说现在有id为1，2，3这三个事务，之后id为3的事务提交了。
				那么一个新的读事务在生成ReadView时，m_ids就包括1和2，min_trx_id的值就是1，max_trx_id的值就是4。
				-- 孩总说的
		-- 对应高水位，即为当前系统已经创建过的最大事务ID加1。 --丁奇说的
		对应 m_low_limit_id/max_trx_id；
		low_limit_id ： 表示的是创建 read view 那一刻活跃的事务列表的最大的事务 ID； --之前的理解，这里描述不对。
		
	4. creator_trx_id ：表示生成该 read view 的事务id。

	-- 这部分的内容理解了。
	

	
	
	
3. 可见性判断规则

	数据版本的可见性规则，就是基于数据的 row trx_id (行记录的事务ID/数据版本ID) 和一致性视图里面的活跃事务ID列表(`m_ids`)对比结果得到的，如下：
	
   准确的说就是基于数据的 row trx_id 跟一致性视图中的同一行记录的活跃事务ID的对比结果得到。
   
   1. 被访问版本的 row trx_id 值与 read view 中的 creator_trx_id 值相同, 可见。
   
	  一个数据版本， 对于一个事务视图来说， 除了自己的更新总是可见 即 当记录的 row trx_id 和 事务创建者的 creator_trx_id 一样，记录可见。 
	  
   2. 处于 `m_ids` 的有两种情况：
   
	  在活跃事务列表中，说明未提交，不可见。 
	  
	  不在活跃事务列表中， 在 m_ids 范围内， 表示这个版本是已经提交了的事务生成的，可见。
	  
	  	  -- 最终对高水位的定义：等于当前系统已经创建过的最大事务ID+1 
	  
   3. m_up_limit_id/min_trx_id：
   
		当记录的当记录的 row trx_id 小于 read view 中的 m_up_limit_id/min_trx_id, 说明 是在视图创建之前已经提交, 可见。 
		
   4. m_low_limit_id/max_trx_id : 
   
		大于此值的是未开启的事务， 不可见。 
	
