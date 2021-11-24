
1. 前言
2. 请求重新计算统计信息的方式
3. 请求重新计算统计信息的流程
4. 参考源码级相关文章
5. 其它待解决


1. 前言

	在MySQL 5.6中，完成统计信息自动计算的是一个后台独立线程(dict_stats_thread)，用于重新计算表或索引的统计信息.
	在一个loop(环形)中，等待事件 dict_stats_event ，或者每隔10秒被无条件唤醒。
	-- 不是很理解
	实际工作函数为 dict_stats_process_entry_from_recalc_pool()
	

	在后台有专门的线程，叫做 dict_stats_thread 来处理统计信息，InnoDB会长期追踪每一张表的行数，判断条件是发现更新的记录超过表记录总数的1/10，那么就把这张表加入到后台的 recalc pool 中，
	而如果变更的行数超过 16+n_rows/16（6.25%），更新非持久化统计信息 。
		

	

2. 请求重新计算统计信息的方式
		
	1. 当手动执行ANALYZE TABLE
	
	2. 进入到自动重新计算后台线程，持久化统计信息在以下情况会被自动更新(先把表的ID加入到 recalc_pool 中)：
			
		1. INNODB_STATS_AUTO_RECALC=ON 情况下，只要满足下面的(1)或者(2)的其中1个条件就会统计到修改表的行数中，当表中10%的数据被修改 ，就会把表的ID加入到 recalc_pool 中。：
			(1). 通过 delete 删除数据
			(2). 通过 update 更新并且有更新二级索引的数据
			-- 所以，数据表只有insert的场景，是不会加入到修改表的行数中的。
			
		2. 添加/删除字段、添加索引。  
			
	3. 打开的表的stats不存在
	
	参考源码：
	
		\mysql-5.7.26\storage\innobase\dict\dict0stats.cc
		
		dict_stats_update() 函数
		
		/* Persistent recalculation requested, called from
			1) ANALYZE TABLE, or
			2) the auto recalculation background thread, or
			3) open table if stats do not exist on disk and auto recalc
			   is enabled 
			   
		请求重新计算统计值的方式：
			1. 当手动执行ANALYZE TABLE
			2. 进入到自动重新计算后台线程(后台线程每隔10秒执行一次？)
			3. 打开的表的stats不存在
		*/	   
	

3. 请求重新计算统计信息的流程

	1. 将表的ID加入到 recalc_pool
		
		1.1 所有需要被重新计算的表会加入到recalc_pool中，recalc_pool初始化大小为128，随后如果需要再被扩大。
		
		1.2 在做完DML后，会调用函数 row_update_for_mysql_using_upd_graph 判断，只要满足下面的其中1个条件就会直接进入 row_update_statistics_if_needed 函数判断是否需要更新统计信息 ：

			1. 只会在DELETE或者UPDATE有更改到索引列，如果只更新到非索引列，那就不会影响统计信息。
			2. delete肯定会影响到所有列
			
				
		1.3 row_update_statistics_if_needed 函数
			
			1. 开启了持久化统计信息
				1. 如果修改表的行数超过10%，会启用自动重新计算统计信息
				2. 把表的ID放进 recalc_pool ，发送 dict_stats_event 事件给 dict_stats_thread 后台线程，并将修改计数器 table->stat_modified_counter 重置为0.
				3. 以上条件不满足，直接return，不进行下面的判断
				
			2. 没有开启持久化统计信息
				当发现修改的记录超过6.25%(1/16)时，更新统计信息 dict_stats_update(table, DICT_STATS_RECALC_TRANSIENT)->dict_stats_update_transient


	2. dict_stats_thread 后台线程如何处理
		
		dict_stats_thread 后台线程接受到 dict_stats_event 事件后，调用工作函数 dict_stats_process_entry_from_recalc_pool()
		
		如果该表在10秒内 已经计算过一次，那么就把该表重新放到 recalc_pool 尾部，不做任何处理(等待下一次统计)。
		否则： 否则真正进入 dict_stats_update 修改统计值
		实际上 DICT_STATS_RECALC_PERSISTENT 类型的状态信息更新，也会由 ANALYZE TABLE 发起
		

	3. 真正进入dict_stats_update()函数修改统计值，在传参为DICT_STATS_RECALC_PERSISTENT时，做三件事：

		1. 检查相关系统表是否存在，不存在报错(dict_stats_persistent_storage_check())
			
		2. 更新表的统计信息(dict_stats_update_persistent(table))
			先更新聚集索引，再更新二级索引，均调用函数 dict_stats_analyze_index.
			
		3. 将统计信息更新到持久化存储系统表中(dict_stats_save(table) )






4. 参考源码级相关文章
	https://developer.aliyun.com/article/41045
	https://tusundong.top/post/empty_cardinality_bug.html	
	http://mysql.taobao.org/monthly/2020/03/08/
	

5. 其它待解决

	1. dict_stats_thread 后台线程多久运行一次？
	2. 添加/删除字段、添加索引 需要把表ID 加入到 recalc_pool 吗？
	
