

创建表失败，字符长度最大不能超过65535字节：
	t_kuaishou_lp_auth_log表，定义的字段长度超过 65535 字节了。
	字符集为utf8mb4, 1个字符占用4个字节， varchar（N）定义的长度不能超过 不能大于16384个字符(65535/4=16384)，其中 N 表示字符长度。


原创建表语句
	create table `t_kuaishou_lp_auth_log`
	(
		id              bigint auto_increment
			primary key comment '主键',
		app_id                     varchar(64)                                  not null default '' comment '店铺ID',
		lp_type                    int(11)            default 0                     not null comment '小程序类型 100店铺小程序 101圈子小程序 ',
		ks_app_id                  varchar(64)                                  not null default '' comment '客户应用Id',
		ks_app_name                varchar(64)                                  not null default '' comment '小程序名称',
		ks_lp_status               int(11)                                      not null default 0 comment '小程序发布状态',
		name_audit                 varchar(2500)                                  not null default '' comment '小程序名称审核',
		ks_app_avatar              varchar(2500)                                  not null default '' comment '头像',
		avatar_audit               varchar(2500)                                  not null default '' comment '头像审核信息',
		ks_app_intro               varchar(2500)                                  not null default '' comment '小程序介绍',
		intro_audit                varchar(2500)                                  not null default '' comment '小程序介绍审核',
		ks_subject                 varchar(2500)                                not null default '' comment '小程序主题信息',
		err_msg                    varchar(2500)                                not null default '' comment '授权错误信息',
		ks_app_category            varchar(2500)                                not null default '' comment '小程序服务类目',
		refresh_token              varchar(512)                                 not null default '' comment 'RefreshAccessToken',
		access_token               varchar(512)                                 not null default '' comment 'AuthAccessToken',
		authorize_permission       varchar(2500)                                null comment '权限集',
		created_at timestamp       not null DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
		updated_at timestamp       not null DEFAULT '1970-01-02 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
		key `index_app_id_ks_app_id` (app_id, ks_app_id),
		key `index_lp_type` (lp_type),
		key `index_ks_app_id` (ks_app_id),
		key `index_created_at` (created_at)
	)comment '快手小程序授权记录'

	mysql> select 2500*9 + 512*2 + 64*3;
	+-----------------------+
	| 2500*9 + 512*2 + 64*3 |
	+-----------------------+
	|                 23716 |
	+-----------------------+
	1 row in set (0.00 sec)
	
	23716 > 16384
	

修改后的创建表语句：
	create table if not exists `t_kuaishou_lp_auth_log`
	(
		id              bigint auto_increment
			primary key comment '主键',
		app_id                     varchar(64)                                  not null default '' comment '店铺ID',
		lp_type                    int(11)            default 0                     not null comment '小程序类型 100店铺小程序 101圈子小程序 ',
		ks_app_id                  varchar(64)                                  not null default '' comment '客户应用Id',
		ks_app_name                varchar(64)                                  not null default '' comment '小程序名称',
		ks_lp_status               int(11)                                      not null default 0 comment '小程序发布状态',
		name_audit                 varchar(2500)                                  not null default '' comment '小程序名称审核',
		ks_app_avatar              varchar(250)                                  not null default '' comment '头像',
		avatar_audit               varchar(2500)                                  not null default '' comment '头像审核信息',
		ks_app_intro               varchar(250)                                  not null default '' comment '小程序介绍',
		intro_audit                varchar(2500)                                  not null default '' comment '小程序介绍审核',
		ks_subject                 varchar(250)                                not null default '' comment '小程序主题信息',
		err_msg                    varchar(250)                                not null default '' comment '授权错误信息',
		ks_app_category            varchar(2500)                                not null default '' comment '小程序服务类目',
		refresh_token              varchar(512)                                 not null default '' comment 'RefreshAccessToken',
		access_token               varchar(512)                                 not null default '' comment 'AuthAccessToken',
		authorize_permission       varchar(2500)                                null comment '权限集',
		created_at timestamp       not null DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
		updated_at timestamp       not null DEFAULT '1970-01-02 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
		key `index_app_id_ks_app_id` (app_id, ks_app_id),
		key `index_lp_type` (lp_type),
		key `index_ks_app_id` (ks_app_id),
		key `index_created_at` (created_at)
	)comment '快手小程序授权记录'

	
	mysql> select 2500*5 + 512*2 + 250*4 + 64*3;
	+-------------------------------+
	| 2500*5 + 512*2 + 250*4 + 64*3 |
	+-------------------------------+
	|                         14716 |
	+-------------------------------+
	1 row in set (0.00 sec)
	
	14716 < 16384
	
	
