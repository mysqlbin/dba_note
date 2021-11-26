
1. 前言
2. 请求重新计算统计信息的方式
3. 请求重新计算统计信息的流程
4. 参考源码级相关文章
5. 其它待解决
6. 小结
7. 如何预防从库的索引统计信息不够新


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
			
		1. INNODB_STATS_AUTO_RECALC=ON 情况下，执行DML语句后，当表中10%的数据被修改 ，就会把表的ID加入到 recalc_pool 中：
			其中，update语句如果只更新到非索引列，那就不会调用该函数，从而不会影响统计信息
			
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
		
		1.2 在做完DML后，会调用 row_update_statistics_if_needed 函数判断是否需要更新统计信息 ：
			其中，update语句如果只更新到非索引列，那就不会调用该函数，从而不会影响统计信息
		
				
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
	http://mysql.taobao.org/monthly/2020/12/05/
	

5. 其它待解决

	1. dict_stats_thread 后台线程多久运行一次？
	
	2. 添加/删除字段、添加索引 需要把表ID 加入到 recalc_pool 吗？
	
	3. 获取表的总行数，应该是从information_schmea.tables获取吗
		n_rows = dict_table_get_n_rows(table);


6. 小结
	
	主库的统计信息相对比较可靠。
		
	从库的不可靠，特别是大表 只有 insert 或者 insert+update 的场景。有读写分离的要注意了，要定期更新从库核心表的统计信息，从而避免因为统计信息不够新，导致SQL选择了错误的索引引发SQL执行速度慢。
	
	如果表有500W行记录，纯 insert 场景，大概要再插入55W行记录 才会触发自动更新统计信息，如果该表每天插入1W行记录，那么大概需要55天才会触发自动更新统计信息
		因此，统计信息相对于当前时间，有55天的落后。
	
		mysql> select 550000/5500000;
		+----------------+
		| 550000/5500000 |
		+----------------+
		|         0.1000 |
		+----------------+
		1 row in set (0.00 sec)
	
	按日期分表的场景，也就是每天1个表。
	
		slave
			mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' order by last_update desc limit 15;
			+---------------+-----------------------------------+---------------------+--------+----------------------+--------------------------+
			| database_name | table_name                        | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
			+---------------+-----------------------------------+---------------------+--------+----------------------+--------------------------+
			| niuniuh5_db   | table_user_gamelock               | 2021-11-24 16:39:15 |     43 |                    1 |                        1 |
			| niuniuh5_db   | table_clubgamescoredetail20211124 | 2021-11-24 16:37:01 |  56250 |                 1315 |                     1158 |
			| niuniuh5_db   | table_clublogscore20211124        | 2021-11-24 16:24:01 |  73116 |                  545 |                      708 |
			| niuniuh5_db   | table_third_score_detail20211124  | 2021-11-24 16:23:40 |  53644 |                  931 |                      450 |
			| niuniuh5_db   | table_webdata_excelexport         | 2021-11-24 13:34:49 |     11 |                    1 |                        2 |
			| niuniuh5_db   | table_third_score_detail20210824  | 2021-11-24 08:30:52 |      0 |                    1 |                        2 |
			
			-- table_clublogscore20210824 表有删除全表的数据。
			| niuniuh5_db   | table_clublogscore20210824        | 2021-11-24 08:26:06 |      0 |                    1 |                        4 |
			| niuniuh5_db   | table_clubgamescoredetail20210824 | 2021-11-24 08:20:45 |      0 |                    1 |                        6 |
			
			-- 下面3个表是按日期分表的场景
			| niuniuh5_db   | table_third_score_detail20211123  | 2021-11-23 23:59:43 |  98154 |                 1764 |                      772 |
			| niuniuh5_db   | table_clublogscore20211123        | 2021-11-23 22:56:31 | 118714 |                  931 |                     1092 |
			| niuniuh5_db   | table_clubgamescoredetail20211123 | 2021-11-23 22:30:13 |  80136 |                 2277 |                     1736 |
			
			| niuniuh5_db   | table_third_score_detail20210823  | 2021-11-23 08:30:38 |      0 |                    1 |                        2 |
			
			-- table_clublogscore20210823 表有删除全表的数据。
			| niuniuh5_db   | table_clublogscore20210823        | 2021-11-23 08:25:51 |      0 |                    1 |                        4 |
			| niuniuh5_db   | table_clubgamescoredetail20210823 | 2021-11-23 08:20:39 |      0 |                    1 |                        6 |
			| niuniuh5_db   | table_third_score_detail20211122  | 2021-11-22 23:57:33 | 105227 |                 1892 |                      772 |
			+---------------+-----------------------------------+---------------------+--------+----------------------+--------------------------+
			15 rows in set (0.00 sec)
		
	------------------------------------------------------------------------------------------------------------------------------------
	表的数据量大，纯insert场景，因此需要插入记录数相对较多，才会触发自动更新统计信息，因此统计信息的最后一次更新时间相对于当前时间，有一定的落后。
	表的数据量小，纯insert场景，不需要插入记录数太多，就会触发自动更新统计信息，因此，统计信息相对较新。
	这里要总结下。
	------------------------------------------------------------------------------------------------------------------------------------

	
	什么是索引统计信息：
		就是表中各个索引的基数
	
	MySQL 优化器选择索引的依据：
		根据索引统计信息(索引基数)来估算扫描的记录数 、是否有使用临时表做group by 分组操作、是否需要排序等做综合考量。
		
		其中，索引基数是采样统计的。
		
		
	索引统计信息的更新时机：
		1. 持久化场景：
			表中的数据修改的行数占总表的10%，因此，大表的索引统计信息的更新时间有一定延迟。
			1个注意事项和1个问题：
				注意事项：update语句如果没有更新索引列，不会计算到修改表的行数中。
				1个问题： 大表只有insert 或者 insert+update的场景，这个表在从库可能会一直不更新索引统计信息。
		
		2. 非持久化场景：
			表中的数据修改的行数占总表的6.25%。
	
	索引统计信息不够新导致的问题：
		优化器选择了错误的索引，导致SQL语句执行慢。
	
			
	案例：
		1. 让where先使用覆盖索引查询出主键ID的最大值和最小值，再把最大值和最小值带入查询条件中，结果优化器没有选择主键索引，而是选择了二级索引，导致了查询慢
			原本耗时2秒的查询，现在耗时8秒
		2. 有where查询条件并且有分组，结果优化器选择了分组列的索引，导致了慢查询
			原本耗时1秒多的查询，现在平均耗时10几秒
			
	如何预防从库的索引统计信息不够新：
	
	------------------------------------------------------------------------------------------------------------------------------------
	
	
	
7. 如何预防从库的索引统计信息不够新
	
	1. 把表统计信息的时间小于当前时间15天的，加入到监控中。
		
		select concat("analyze table ", table_name, ";") from mysql.innodb_table_stats  where database_name='niuniuh5_db' and last_update < DATE_SUB(NOW(), INTERVAL 3 DAY);
		
	2. 停服更新，在主库对指定的业务表，执行一遍 analyze table 操作。
	
	3. 添加定时器，每天的1号、15号，对在从库对指定的业务表，执行一遍 analyze table 操作。
		这个操作要避开备份的时间。
		

	
	
