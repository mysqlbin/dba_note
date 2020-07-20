


这个ReadView中主要包含4个比较重要的内容：
	
	1. m_ids：表示在生成ReadView时当前系统中活跃的读写事务的事务id列表。

	2. min_trx_id：表示在生成ReadView时当前系统中活跃的读写事务中最小的事务id，也就是m_ids中的最小值。
		
		对应低水位即数组里面事务ID的最小值即 m_up_limit_id/min_trx_id；
		
	3. max_trx_id：表示生成ReadView时系统中应该分配给下一个事务的id值。

		小贴士： 注意max_trx_id并不是m_ids中的最大值，事务id是递增分配的。比方说现在有id为1，2，3这三个事务，之后id为3的事务提交了。
				那么一个新的读事务在生成ReadView时，m_ids就包括1和2，min_trx_id的值就是1，max_trx_id的值就是4。
		
		对应高水位，即为当前系统已经创建过的最大事务ID加1
		对应 m_low_limit_id/max_trx_id；
				
	4. creator_trx_id：表示生成该ReadView的事务的事务id。

	-- 这部分的内容理解了。
	

	low_limit_id： 表示的是创建 read view 那一刻活跃的事务列表的最大的事务 ID； --之前的理解，这里描述不对。
	
	

  