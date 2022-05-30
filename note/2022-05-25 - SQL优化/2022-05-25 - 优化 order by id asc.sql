

sql语句

	select `app_id`, `id`, `alive_type`, `room_id`, `rewind_time` from `t_alive` where (`channel_id` = '5060_Gpk7dTFpW3kTWWkp') order by `id` asc limit 1 
	channel_id是普通索引列。
	有时执行慢(耗时10几秒)，有时执行很快(耗时0.01秒)。原因：优化器有时选择了 主键id 这个错误的索引，导致sql有时执行很慢。
	
改为

select `app_id`, `id`, `alive_type`, `room_id`, `rewind_time` from `t_alive` where (`channel_id` = '5060_Gpk7dTFpW3kTWWkp')  limit 1 

或者  

select `app_id`, `id`, `alive_type`, `room_id`, `rewind_time` from `t_alive` where (`channel_id` = '5060_Gpk7dTFpW3kTWWkp') order by channel_id asc,`id` asc  limit 1 


----------------------------------------------------------------------------------------------------------------------------------------


select `app_id`, `id`, `alive_type`, `room_id`, `rewind_time` from `t_alive` where (`channel_id` = '5060_Gpk7dTFpW3kTWWkp') order by `id` desc limit 1 

改为 

select `app_id`, `id`, `alive_type`, `room_id`, `rewind_time` from `t_alive` where (`channel_id` = '5060_Gpk7dTFpW3kTWWkp') order by channel_id desc,`id` desc limit 1 

idx_channel_id

channel_id	id
1			3
3			10
5			5
5			6
6           15





