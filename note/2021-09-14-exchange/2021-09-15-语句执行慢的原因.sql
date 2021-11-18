

大纲
	1. 查询一行记录返回慢的现象(原因)的分析思路/复现和解决办法
	2. 一条 SQL 语句执行的很慢
	3. 小结
	4. 相关参考

1. 查询一行记录返回慢的现象(原因)的分析思路/复现和解决办法
	
	select * from t where id=1;
	
	1.1 第一类：查询长时间不返回
		
		1. 分析步骤
		
			1. 先执行 show processlist命令，看看当前语句处于什么状态；
			2. 针对每种状态，分析它们产生的原因、如何复现、如何处理。
		
		2. 等MDL锁
		3. 等flush关闭表
		4. 等行锁
		
	1.2 第二类：查询慢
		MVCC的undo链表过长，导致查询慢。
	
	1.3 其它原因
		1. 没有用上索引：
			字段没有索引
			由于对字段进行运算、函数操作导致无法用索引

		2. 数据库选错了索引也就是选择的索引并不是最优的
		
--------------------------------------------------------------------------------------------
	
2. 一条 SQL 语句执行的很慢

	得分以下两种情况来讨论
	
	2.1 大多数情况是正常的，只是偶尔会出现很慢的情况，有如下原因
	
		1. redo log写满
		
		2. BP内存缓冲池没有可用的空闲空间(需要淘汰lru列表的数据页或者刷脏页)

		3. 执行的时候，遇到锁，如表锁、行锁。
		
		4. 做一些比较重的维护操作，也会让SQL语句响应变慢，比如
			1. 执行drop table操作，该操作主要是对锁数据字典加全局的排他锁，会阻塞DML语句。
			2. 添加索引，磁盘利用率高。
			3. 在线调整BP缓冲池的大小。
			4. 通过purge操作删除大量的binlog文件，需要花费较长的时间，涉及到剧烈io波动，此时会影响业务的响应时间
			
	2.2 在数据量不变的情况下，这条SQL语句一直以来都执行的很慢，有如下原因
	
		1. 没有用上索引：
			字段没有索引
			由于对字段进行运算、函数操作导致无法用索引

		2. 数据库选错了索引也就是选择的索引并不是最优的
		
		
	
3. 小结
	
	1. SQL慢要么做了太多事，要么等的太久了。
		-- 掌握一定延迟分布的观测方法，方能准确定位性能问题。
		做了太多的事情：
			1. 查询字段没有索引，导致全表扫描
			2. 查询字段有索引，但是没有用到索引，比如对字段做了函数操作、隐式数据类型转换、隐式字符编码转换
			3. 查询的数据量太多
		等得太久：
			等表锁、MDL锁、行锁 
			
	2. 当mysqld进程消耗CPU很高时，极大概率是有些SQL没索引导致
	
	3. 具体问题具体分析
		查询的是多行记录还是1行记录
		是偶尔慢还是经常慢	


	
4. 相关参考
		
	https://mp.weixin.qq.com/s/ry9Kfh9Z1Tx3ux9k-V15nA   一条SQL语句执行得很慢的原因有哪些？ 
	18：索引字段做函数操作和对应的优化 | 为什么这些SQL语句逻辑相同，性能却差异巨大？  --隐式转换
	19：查询一行记录返回慢的现象/原因的分析思路/复现和解决办法
		对索引字段做函数操作，可能会破坏索引值的有序性
		
		