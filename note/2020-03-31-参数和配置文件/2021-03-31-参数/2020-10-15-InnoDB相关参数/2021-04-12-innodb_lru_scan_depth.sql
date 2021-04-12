
控制LRU列表中可用页的数量, 该值默认为1024 

当系统的IO比较空闲的时候，可以适当将这个参数设大，当IO吃紧时，需要适当减小
	-- 有待验证。
	
参考
	https://www.cnblogs.com/zengkefu/p/5692803.html

	《2020-10-27-InnoDB buffer pool缓冲池的重新学习和整理》