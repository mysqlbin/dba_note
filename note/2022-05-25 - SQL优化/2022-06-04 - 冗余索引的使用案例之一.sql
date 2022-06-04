

id 是主键

sql语句1： 
	select `app_id`, `id`, `alive_type`, `room_id`, `rewind_time` from `t_alive` where (`channel_id` = '5060_Gpk7dTFpW3kTWWkp') order by `id` asc limit 1;
sql语句2：
	select `app_id`, `id`, `alive_type`, `room_id`, `rewind_time` from `t_alive` where (`channel_id` = '5060_Gpk7dTFpW3kTWWkp') and rewind_time = "xxx" order by `id` asc limit 1;

idx_channel_id(`channel_id`) 
idx_channel_id_rewind_time(`channel_id`,`rewind_time`)

这里给 channel_id 字段建立索引，是有用途的， sql语句1 使用 idx_channel_id 索引，可以消除排序，在高并发场景，不会导致cpu利用率高。





