
简单描述MySQL MVCC机制

1. MVCC 就是多版本控制，基于 read view + undo 实现MVCC
	
	基于MVCC，就可以实现 RC读已提交和RR可重复读事务隔离级别。

2. 可见性判断
	判断方式：
		根据行记录的版本和活跃事务的ID列表也就是read view做对比
	
	1. 行记录的版本号小于活跃事务ID列表的最小ID，可见 
	2. 对自己的更新可见(行记录的版本号在活跃事务ID列表中)
	3. 行记录的版本号在活跃事务ID列表范围内，不在活跃事务ID列表中，不可见
	4. 行记录的版本号大于活跃事务ID列表的最大ID，不可见 
		
	-- 这部分的源码有阅读过。
	
	