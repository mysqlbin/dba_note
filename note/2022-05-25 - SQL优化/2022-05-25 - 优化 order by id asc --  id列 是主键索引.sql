

sql语句

	select `app_id`, `id`, `alive_type`, `room_id`, `rewind_time` from `t_alive` where (`channel_id` = '5060_Gpk7dTFpW3kTWWkp') order by `id` asc limit 1 
	channel_id是普通索引列：KEY `channel_index` (`channel_id`, `rewind_time`)
	有时执行慢(耗时10几秒)，有时执行很快(耗时0.01秒)。
	
	原因：优化器有时选择了 id主键索引，因为选择主键索引，是不需要排序的，但是实际上导致sql语句有时执行很慢。
	
	执行计划：
		key = channel_index
		key_len = 258
		rows = 1
		Extra = Using index condition; Using where; Using filesort
		
	
	
	
2. 优化方式1
	给 channel_id 字段建立独立的索引。 
	KEY `idx_channel_id` (`channel_id`)


	idx_channel_id 索引的数据结构：

		channel_id	id
		1			3
		3			10
		5			5
		5			6
		6           15


----------------------------------------------------------------------------------------------------------------------------------------

3. 如果是 order by id desc 

	同样给 channel_id 字段建立独立的索引。 
	KEY `idx_channel_id` (`channel_id`)
	
	select `app_id`, `id`, `alive_type`, `room_id`, `rewind_time` from `t_alive` where (`channel_id` = '5060_Gpk7dTFpW3kTWWkp') order by `id` desc limit 1 

	改为 

	select `app_id`, `id`, `alive_type`, `room_id`, `rewind_time` from `t_alive` where (`channel_id` = '5060_Gpk7dTFpW3kTWWkp') order by channel_id desc,`id` desc limit 1 


4. 小结
	冗余索引也是有用途的，同时参考笔记：《2022-06-04 - 冗余索引的使用案例之一.sql》

