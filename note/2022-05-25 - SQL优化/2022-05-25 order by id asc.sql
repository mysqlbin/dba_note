select `app_id`, `id`, `alive_type`, `room_id`, `rewind_time` from `t_alive` where (`channel_id` = '5060_Gpk7dTFpW3kTWWkp') order by `id` asc limit 1 


select `app_id`, `id`, `alive_type`, `room_id`, `rewind_time` from `t_alive` where (`channel_id` = '5060_Gpk7dTFpW3kTWWkp') order by channel_id desc,`id` desc limit 1 

idx_channel_id

channel_id	id
1			3
3			10
5			5
5			6
6           15



(`channel_id` = '5060_Gpk7dTFpW3kTWWkp') order by channel_id asc,`id` asc 

