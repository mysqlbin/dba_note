


1. 读取数据和发送数据的流程
	MySQL的查询结果发送给客户端的流程
	net_buffer         -- server端
	socket send buffer -- 操作系统层
	socket receive buffer -- 客户端

	把记录写到 net_buffer 中，当net_buffer达到16KB, 就调用网络接口 socket send buffer 把数据发送给客户端

				
				
2. InnoDB对应LRU算法的改进

	传统的LRU算法：
		最晚访问的放在LRU链表的最前面，最早访问的放在LRU链表的最后面
		当有一个新的数据页需要读入内存中并且此时内存没有空闲页可以用，那么会淘汰一个尾部的数据页，这个新的数据页会写入到LRU链表的最前面。
		
	传统LRU算法存在的问题：
		会把LRU链表的数据全部淘汰出去； 
		假设 innodb_buffer_pool_size=10GB, 某个大表的数量为30GB，当触发大表的全表扫描，会把LRU链表的数据全部淘汰出去；
		此时内存命中率很低，执行DML和SELECT语句会很慢。
		
	InnDB对LRU算法的优化
		把LRU链表分为 young区域 和 old区域，young区域 占5/8的大小， old区域占 3/8 的大小
		当需要把数据页读入内存中，会先写入 old区域的头部， 如果这个数据页在 old区域停留时间超过1秒再次被访问，那么就会加入 young 链表的头部
		这个1秒的阀值由参数innodb_old_blocks_time控制

		假设 innodb_buffer_pool_size=10GB, 某个大表的数量为30GB，当触发大表的全表扫描，会依次写入到 old区域的头部； 
		当全表扫描顺序访问old区域中同一个数据页的记录，数据页没有超过1秒再次被访问，所以数据页不会移动到 young区域的头部。
		
			
		
3. OOM
	innodb_buffer_pool_size 设置太大，再加上server层使用的内存，导致内存超过系统上限被OOM。
	-- 这个是自己有遇到过的。

	
	

