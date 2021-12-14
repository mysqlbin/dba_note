

1. 维护操作相关
	
	drop table、truncate table、drop index、analyze table 请求重新计算索引统计信息、在线修改BP缓冲池、purge binary log  
	-- 基本的流程 加的什么锁、什么时候释放，对业务有什么影响 
	
	drop table 需要加的锁：MDL写锁、buffer pool mutex、flush list mutex、数据字典锁，不需要扫描 lru list的数据
    truncate table语句：需要扫描该表在 lru list 的数据，因此，持有的 buffer pool mutex、flush list mutex 更长，所以 truncate table语句 比 drop table 的代价高。
		
	
2. 原理相关
	
	1. MVCC 多版本并发控制，判断记录可见性 
        undo 部分：DML操作在undo中记录的值

    2. 锁部分
        
		select 语句加排他锁或者共享锁的流程
		
		行锁的加锁规则：row_search_mvcc 看了好几遍，越看越明了
		
        先懂得基本的加锁原理、做实验、看源码、打断点调试、查看函数调用栈
		
        死锁部分
        insert 语句隐式锁转为显示锁
		
	3. seconds_behind_master 的计算方式
	
	4. 记录慢日志的源码
	
	

3. 优化相关
	1. timestamp 时间戳字段的时区转换
	2. 切换数据库 use db 命令执行慢的原因
		
	5.7 版本的缓冲池mutex互斥锁  -- 带问题找源码

 