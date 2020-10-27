

net_buffer         -- server端
socket send buffer -- 操作系统层
socket receive buffer -- 客户端

把记录写到 net_buffer 中，当net_buffer达到16KB, 就调用网络接口 socket send buffer 把数据发送给客户端
此时客户端负责接收

网络接口 socket send buffer 写满，暂停读数据的流程
	这时候会进入等待： show processlist.state 字段显示 Writing to net/Sending to client; 直到网络栈重新可写，再继续发送。
	发送函数会返回 EAGAIN (eagain)或 WSAEWOULDBLOCK(wsaewouldblock)

	Sending to client
	
		表示 仅当一个线程处于 等待客户端接收结果 的状态，才会显示 Sending to client；
		
		State 的值一直处于 Sending to client，就表示服务器端的网络栈（socket send buffer）写满了，这是一个需要优化的点；
		
		多个线程处于 Sending to client 状态的解决办法：
			1. 优化查询结果，并评估这么多的返回结果是否合理；
			2. 快速减少处于这个状态的线程，可以将 net_buffer_length 参数设置为一个更大的值。
				--这里还不理解。
				net_buffer_length 的最大值是 1G，这个值比 socket send buffer大（一般是几M）
				比如假设一个业务，他的平均查询结果都是10M （当然这个业务有有问题，最终是要通过业务解决）
				但是如果我把 net_buffer_length 改成10M，就不会有“Sending to client” 的情况。虽然网络栈还是慢慢发的，但是那些没发完的都缓存在net_buffer中，对于执行器来说，都是“已经写出去了”。
				
				
MySQL对于查询数据的处理思路是 边读边发 的，如果客户端接收慢，会导致MySQL server端的结果发送不出去，事务执行耗时会变长。



InnoDB改进的LRU算法，如果遇到连续两次的全表扫描，会不会就把young区的3/5给覆盖掉了？因为两次扫描时间间隔会超过一秒？
	会的。
	
	
还有是 innodb_buffer_pool_size 设置太大，再加上server层使用的内存，导致内存超过系统上限被oom。
	-- 这个是自己有遇到过的。
	
	