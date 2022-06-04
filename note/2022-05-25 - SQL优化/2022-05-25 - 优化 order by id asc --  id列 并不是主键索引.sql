

1. sql语句

	select `app_id`, `id`, `alive_type`, `room_id`, `rewind_time` from `t_alive` where (`channel_id` = '5060_Gpk7dTFpW3kTWWkp') order by `id` asc limit 1 
	
	channel_id是普通索引列：KEY `channel_index` (`channel_id`, `rewind_time`)
	有时执行慢(耗时10几秒)，有时执行很快(耗时0.01秒)。
	原因：优化器有时选择了 id 这个错误的普通索引，因为优化器觉得不需要排序，sql语句执行的速度更快，但是导致了sql语句有时执行很慢。
	
	正常情况下使用到 channel_index索引 的执行计划：
		key = channel_index
		key_len = 258
		rows = 1
		Extra = Using index condition; Using where; Using filesort
			
	
	
2. 优化方式1

	建立由 channel_id + id 这2列组成的联合索引
		alter table `db_ex_alive`.`t_alive` add  index index_channel_id_id(`channel_id`, `id`);

	index_channel_id_id联合索引的数据结构

		channel_id	id
		1			3
		3			10
		5			5
		5			6
		6           15


3. 优化方式2 
	force index channel_index
	这种优化方式并不是最优的。
	
4. 表的DDL

	CREATE TABLE `t_alive` (
	`app_id` varchar(64) NOT NULL COMMENT '应用Id',
	`id` varchar(128) NOT NULL COMMENT '直播任务id',
	`room_id` varchar(128) NOT NULL COMMENT '直播房间id',
	`zb_user_id` varchar(512) DEFAULT NULL COMMENT '主播的用户id',
	`zb_user_name` varchar(256) DEFAULT NULL COMMENT '主播的用户昵称',
	`title` varchar(64) DEFAULT NULL COMMENT '直播名称（标题）',
	`summary` varchar(256) DEFAULT NULL COMMENT '直播简介',
	`descrb` mediumtext COMMENT '直播描述(Json格式, type:0-文字 1-图片)',
	`org_content` mediumtext COMMENT '原始的html标签',
	`file_name` varchar(64) DEFAULT NULL COMMENT '文件名称',
	`img_url` varchar(256) DEFAULT NULL COMMENT '直播封面url',
	`img_url_compressed_larger` varchar(256) NOT NULL DEFAULT '' COMMENT '压缩列表配图url-大图',
	`img_url_compressed` varchar(256) DEFAULT NULL COMMENT '封面压缩后的路径',
	`alive_img_url` varchar(256) DEFAULT NULL COMMENT '首页展示的直播图',
	`aliveroom_img_url` varchar(256) DEFAULT NULL COMMENT '直播间封面图',
	`file_id` varchar(64) DEFAULT NULL COMMENT '视频点播视频id',
	`alive_type` int(4) NOT NULL DEFAULT '0' COMMENT '直播类型,0-语音直播,1-视频直播,2-推流直播,3-ppt直播',
	`alive_video_url` varchar(256) DEFAULT NULL COMMENT '直播视频url',
	`alive_m3u8_high_size` float NOT NULL DEFAULT '0' COMMENT '视频转码为m3u8后大小（如：10M）',
	`alive_m3u8_high_vbitrate` int(11) NOT NULL DEFAULT '0' COMMENT '视频转码为m3u8后大小（如：10M）',
	`list_file_content` mediumtext COMMENT '清单内容',
	`video_size` float DEFAULT '0' COMMENT '视频大小（M）',
	`video_length` int(11) NOT NULL DEFAULT '0' COMMENT '视频时长（s）',
	`zb_start_at` timestamp NULL DEFAULT NULL COMMENT '直播开始时间',
	`zb_stop_at` timestamp NULL DEFAULT NULL COMMENT '直播关闭时间',
	`manual_stop_at` timestamp NULL DEFAULT NULL COMMENT '主播手动结束直播时间',
	`start_at` timestamp NULL DEFAULT NULL COMMENT '上架时间',
	`stop_at` timestamp NULL DEFAULT NULL COMMENT '下架时间',
	`is_transcode` int(11) NOT NULL DEFAULT '0' COMMENT '视频是否转码，0-表示未转码，1-表示已转码,2-转码失败',
	`state` int(11) DEFAULT '0' COMMENT '直播状态(0-可见 1-关闭 2-删除)',
	`trans_temp_state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '转码未成功前的临时显示状态',
	`recycle_bin_state` tinyint(1) DEFAULT '0' COMMENT '上下架状态（0-上架，1-下架）',
	`old_recycle_bin_state` tinyint(1) DEFAULT '0' COMMENT '原回收站状态（0-不在回收站中，1-在回收站中）,回收站状态代表该资源无售卖形式（非单卖无关联）',
	`sell_mode` tinyint(1) DEFAULT '0' COMMENT '销售类型（0-自营商品，1-内容市场商品）',
	`view_count` int(11) DEFAULT '0' COMMENT '浏览量',
	`comment_count` int(11) DEFAULT '0' COMMENT '评论数量',
	`payment_type` int(11) NOT NULL COMMENT '付费类型：1-免费、2-单笔、3-付费产品包',
	`is_public` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否公开售卖，1公开，0不公开',
	`piece_price` int(11) DEFAULT NULL COMMENT 'payment_type为2时，单笔价格（分）;payment_type为3时，专栏价格（分）',
	`line_price` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '划线价',
	`is_stop_sell` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否停售（0-否、1-是）',
	`product_id` varchar(256) DEFAULT NULL COMMENT 'payment_type为3时，绑定的付费产品包id',
	`product_name` varchar(64) DEFAULT NULL COMMENT '产品包名',
	`product_state` int(11) DEFAULT '0' COMMENT '产品包（专栏）状态，与t_pay_product表的状态要同步，是否可见（0-可见（上架） 1-隐藏（下架））',
	`if_push` int(11) DEFAULT '1' COMMENT '是否推送直播开始消息,0-是,1-否,2-已推送,3-推送失败',
	`if_push_start` int(11) DEFAULT '1' COMMENT '是否推送上新消息,0-是,1-否,2-已推送,3-推送失败',
	`push_state_outline` tinyint(2) NOT NULL DEFAULT '0' COMMENT '直播开始消息推送离线脚本推送状态0-未发送 1-发送中 2-已发送 3-发送失败',
	`push_start_state_outline` tinyint(2) NOT NULL DEFAULT '0' COMMENT '上新消息推送离线脚本推送状态0-未发送 1-发送中 2-已发送 3-发送失败',
	`chosen_weight` int(8) NOT NULL DEFAULT '0' COMMENT '商品显示优先级；数字大的排在前面',
	`config_show_reward` int(2) DEFAULT '0' COMMENT '打赏提醒显示设置：0-所有人可见，1-仅讲师和打赏人可见',
	`config_show_view_count` int(2) DEFAULT '0' COMMENT '直播人次显示设置：0-所有人可见，1-仅讲师可见',
	`ppt_imgs` mediumtext COMMENT 'ppt素材图片数组(json)',
	`is_chosen` int(11) NOT NULL DEFAULT '0' COMMENT '是否是精选 0 否 1 是',
	`is_discount` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否参与折扣:默认0-不参与，1-参与',
	`push_ahead` int(11) DEFAULT '5' COMMENT '消息推送提前时间，默认5分钟',
	`notified` int(11) DEFAULT '0' COMMENT '是否已生成消息通知任务 0-未生成 1-已生成(暂未使用)',
	`forbid_talk` int(11) DEFAULT '0' COMMENT '是否全员禁言状态（0代表自由发言状态，1代表除讲师外全员禁言状态)',
	`share_imgs` mediumtext COMMENT '直播间讲师共享图片,jsonArray',
	`period` int(11) DEFAULT NULL COMMENT '有效期（秒）',
	`has_distribute` int(11) NOT NULL DEFAULT '0' COMMENT '是否参与分销 0-不参与 1-参与',
	`new_has_distribute` tinyint(4) NOT NULL DEFAULT '0' COMMENT '资源是否参与推广员分销 0-不参与 1-参与',
	`invite_poster` varchar(256) NOT NULL DEFAULT '' COMMENT '邀请卡海报url',
	`is_show_userinfo` tinyint(2) NOT NULL DEFAULT '0' COMMENT '邀请卡海报是否显示用户信息：0-不显示，1-显示',
	`distribute_poster` varchar(256) NOT NULL DEFAULT '' COMMENT '推广海报url',
	`is_distribute_show_userinfo` tinyint(2) NOT NULL DEFAULT '1' COMMENT '推广员海报是否显示用户信息：0-不显示,1-显示',
	`distribute_default` int(11) NOT NULL DEFAULT '0' COMMENT '邀请卡分销比例是否使用全局默认值（0-使用配置默认值，1-使用自定义值）(暂未使用)',
	`distribute_percent` decimal(10, 4) DEFAULT '0.0000' COMMENT '普通推广员邀请比例—邀请卡分销比例(百分点1-100)',
	`first_distribute_default` int(11) NOT NULL DEFAULT '0' COMMENT '本级分销比例是否使用全局默认值（0-使用配置默认值，1-使用自定义值）',
	`first_distribute_percent` decimal(10, 4) DEFAULT '0.0000' COMMENT '高级推广员佣金比例--本级分销比例(百分点1-100)',
	`superior_distribute_default` int(11) NOT NULL DEFAULT '0' COMMENT '上级分销比例是否使用全局默认值（0-使用配置默认值，1-使用自定义值）',
	`superior_distribute_percent` decimal(10, 4) DEFAULT '0.0000' COMMENT '邀请比例奖励—上级分销比例(百分点1-100)',
	`can_select` int(11) DEFAULT '1' COMMENT '直播详情描述是否允许选中复制（0-不允许，1-允许）',
	`channel_id` varchar(64) NOT NULL DEFAULT '' COMMENT '推流房间，直播房间号',
	`push_state` tinyint(3) NOT NULL DEFAULT '2' COMMENT '推流状态，0断流，1推流中，2推流未开始',
	`push_callback_files` mediumtext COMMENT '视频推流返回的视频',
	`rewind_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '推流状态的时间',
	`play_url` varchar(1024) NOT NULL DEFAULT '' COMMENT '直播推流播放地址',
	`push_url` varchar(255) NOT NULL DEFAULT '' COMMENT '推流地址',
	`txtime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '推流链接有效时间',
	`alive_channel` int(11) DEFAULT '0' COMMENT '直播来源，0-未知 1-H5讲师端 2-PC讲师端 3-IOS推流端 4-Android推流端',
	`can_record` int(2) DEFAULT '0' COMMENT '用户上麦开关(0-关闭，1-开启（用户可语音到讲师区））',
	`show_on_wall` int(2) DEFAULT '0' COMMENT '用户发言上墙开关(0-关闭，1-开启(用户发言到讲师区))',
	`have_password` int(2) NOT NULL DEFAULT '0' COMMENT '该资源是否需要密码',
	`resource_password` varchar(32) DEFAULT NULL COMMENT '资源密码',
	`wy_addr` varchar(64) DEFAULT NULL COMMENT '网易roomid对应的房间地址',
	`is_lookback` tinyint(4) DEFAULT '1' COMMENT '是否开启回看，0代表不开启，1代表开启 ',
	`watermark_id` int(11) DEFAULT '0' COMMENT '是否有水印，0代表没有，其他代表水印ID',
	`is_takegoods` tinyint(4) DEFAULT '0' COMMENT '是否开启直播带货，0代表不开启，1代表开启',
	`takegoods` varchar(64) DEFAULT '0' COMMENT '直播带货，商品所存的商品分组ID，0代表没有',
	`wy_roomid` varchar(64) DEFAULT NULL COMMENT '网易roomid',
	`wy_token` varchar(64) DEFAULT NULL COMMENT '网易accid对应的token',
	`wy_accid` varchar(64) DEFAULT NULL COMMENT '网易accid',
	`wy_appkey` varchar(64) DEFAULT NULL COMMENT '网易appkey',
	`is_complete_info` int(11) NOT NULL COMMENT '用户是否需要补全资料 0-否 1-是',
	`created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
	`updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间，有修改自动更新',
	`create_client` int(2) NOT NULL DEFAULT '0' COMMENT '新建来源（默认0-管理端；1-手机端）',
	`complete_voice_url` varchar(256) DEFAULT NULL COMMENT '完整拼接的语音url',
	`complete_state` int(2) NOT NULL DEFAULT '2' COMMENT '异步下载完整语音状态 3-出错 2-未下载 1-下载中 0-已完成',
	`msg_push_state` int(2) DEFAULT '0' COMMENT '短信推送状态 0-未推送 1-推送中 2-推送成功 3-推送失败',
	`create_mode` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0-自创建，1-转播创建',
	PRIMARY KEY (`app_id`, `id`),
	KEY `index_id` (`id`),
	KEY `index_room_id` (`room_id`),
	KEY `index_template_push` (`state`, `if_push`),
	KEY `index_created_at` (`created_at`),
	KEY `channel_index` (`channel_id`, `rewind_time`),
	KEY `index_new_template_push` (`state`, `if_push_start`, `start_at`),
	KEY `file_id` (`file_id`),
	KEY `idx_zb_start` (`zb_start_at`),
	KEY `app_id_push_state_index` (`app_id`, `push_state`),
	KEY `app_id_zb_start_index` (`app_id`, `zb_start_at`)
	) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '直播任务表'