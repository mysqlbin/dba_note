2. mysql 的truncate 清空库表权限，如何授权
	Drop权限代表允许删除数据库、表、视图的权限，包括truncate table命令
	
	
3. mysql 的rename表权限，如何授权        
	如果我们使用 RENAME TABLE 语句，则需要对现有表具有 ALTER 和 DROP TABLE 权限。
	-- 需要验证下。
	


alter table db_boss.t_r_app_version_detail_nozero_dt rename to db_boss.t_r_app_version_detail_nozero_dt_t
alter table db_boss.t_r_app_version_detail_nozero_dt_tmp rename to db_boss.t_r_app_version_detail_nozero_dt
alter table db_boss.t_r_app_version_detail_nozero_dt_t rename to db_boss.t_r_app_version_detail_nozero_dt_tmp

	
10.0.14.73
10.0.14.151

新订单库:        sh-cdb-new-order-rw.xiaoe-conf.com
新订单库-快只读: sh-cdb-new-orders-service-rf.xiaoe-conf.com



CREATE TABLE `t_page_statistics_info` (
`id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
`visit_day` varchar(64) NOT NULL DEFAULT '' COMMENT '日期',
`app_id` varchar(64) NOT NULL DEFAULT '' COMMENT '店铺id',
`channel_id` varchar(64) NOT NULL DEFAULT '' COMMENT '页面统计id',
`user_id` varchar(100) NOT NULL DEFAULT '' COMMENT '用户id',
`visit_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '访问时间',
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
PRIMARY KEY (`id`, `visit_day`),
KEY `up_at` (`updated_at`),
KEY `idx_app_channel_user` (`app_id`, `channel_id`, `user_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1576588 DEFAULT CHARSET = utf8 COMMENT = '页面统计访问明细数据'
/*!50500 PARTITION BY RANGE COLUMNS(visit_day)
(PARTITION p20221115 VALUES LESS THAN ('2022-11-16') ENGINE = InnoDB,
PARTITION p20221116 VALUES LESS THAN ('2022-11-17') ENGINE = InnoDB,
PARTITION p20221117 VALUES LESS THAN ('2022-11-18') ENGINE = InnoDB,
PARTITION p20221118 VALUES LESS THAN ('2022-11-19') ENGINE = InnoDB,
PARTITION p20221119 VALUES LESS THAN ('2022-11-20') ENGINE = InnoDB,
PARTITION p20221120 VALUES LESS THAN ('2022-11-21') ENGINE = InnoDB,
PARTITION p20221121 VALUES LESS THAN ('2022-11-22') ENGINE = InnoDB,
PARTITION p20221122 VALUES LESS THAN ('2022-11-23') ENGINE = InnoDB) */




mysql> show create table t_page_statistics_info\G;
*************************** 1. row ***************************
       Table: t_page_statistics_info
Create Table: CREATE TABLE `t_page_statistics_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `visit_day` varchar(64) NOT NULL DEFAULT '' COMMENT '日期',
  `app_id` varchar(64) NOT NULL DEFAULT '' COMMENT '店铺id',
  `channel_id` varchar(64) NOT NULL DEFAULT '' COMMENT '页面统计id',
  `user_id` varchar(100) NOT NULL DEFAULT '' COMMENT '用户id',
  `visit_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '访问时间',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`visit_day`),
  KEY `up_at` (`updated_at`),
  KEY `idx_app_channel_user` (`app_id`,`channel_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1576588 DEFAULT CHARSET=utf8 COMMENT='页面统计访问明细数据'
/*!50500 PARTITION BY RANGE  COLUMNS(visit_day)
(PARTITION p20221115 VALUES LESS THAN ('2022-11-16') ENGINE = InnoDB,
 PARTITION p20221116 VALUES LESS THAN ('2022-11-17') ENGINE = InnoDB,
 PARTITION p20221117 VALUES LESS THAN ('2022-11-18') ENGINE = InnoDB,
 PARTITION p20221118 VALUES LESS THAN ('2022-11-19') ENGINE = InnoDB,
 PARTITION p20221119 VALUES LESS THAN ('2022-11-20') ENGINE = InnoDB,
 PARTITION p20221120 VALUES LESS THAN ('2022-11-21') ENGINE = InnoDB,
 PARTITION p20221121 VALUES LESS THAN ('2022-11-22') ENGINE = InnoDB,
 PARTITION p20221122 VALUES LESS THAN ('2022-11-23') ENGINE = InnoDB) */
1 row in set (0.00 sec)

ERROR: 
No query specified





create user 'warning_user'@'%' identified by '123456abc';
grant alter on *.* to 'warning_user'@'%' with grant option;


alter table t_page_statistics_info add partition(partition p20221123 VALUES LESS THAN ('2022-11-24') ENGINE = InnoDB);


mysql> show create table t_page_statistics_info\G;
*************************** 1. row ***************************
       Table: t_page_statistics_info
Create Table: CREATE TABLE `t_page_statistics_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `visit_day` varchar(64) NOT NULL DEFAULT '' COMMENT '日期',
  `app_id` varchar(64) NOT NULL DEFAULT '' COMMENT '店铺id',
  `channel_id` varchar(64) NOT NULL DEFAULT '' COMMENT '页面统计id',
  `user_id` varchar(100) NOT NULL DEFAULT '' COMMENT '用户id',
  `visit_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '访问时间',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`visit_day`),
  KEY `up_at` (`updated_at`),
  KEY `idx_app_channel_user` (`app_id`,`channel_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1576588 DEFAULT CHARSET=utf8 COMMENT='页面统计访问明细数据'
/*!50500 PARTITION BY RANGE  COLUMNS(visit_day)
(PARTITION p20221115 VALUES LESS THAN ('2022-11-16') ENGINE = InnoDB,
 PARTITION p20221116 VALUES LESS THAN ('2022-11-17') ENGINE = InnoDB,
 PARTITION p20221117 VALUES LESS THAN ('2022-11-18') ENGINE = InnoDB,
 PARTITION p20221118 VALUES LESS THAN ('2022-11-19') ENGINE = InnoDB,
 PARTITION p20221119 VALUES LESS THAN ('2022-11-20') ENGINE = InnoDB,
 PARTITION p20221120 VALUES LESS THAN ('2022-11-21') ENGINE = InnoDB,
 PARTITION p20221121 VALUES LESS THAN ('2022-11-22') ENGINE = InnoDB,
 PARTITION p20221122 VALUES LESS THAN ('2022-11-23') ENGINE = InnoDB,
 PARTITION p20221123 VALUES LESS THAN ('2022-11-24') ENGINE = InnoDB) */
1 row in set (0.00 sec);



mysql> alter table t_page_statistics_info rename t_page_statistics_info_new;
ERROR 1142 (42000): DROP command denied to user 'warning_user'@'localhost' for table 't_page_statistics_info'


mysql> truncate table t_page_statistics_info;
ERROR 1142 (42000): DROP command denied to user 'warning_user'@'localhost' for table 't_page_statistics_info';






alter table db_boss.t_r_app_version_detail_nozero_dt rename to db_boss.t_r_app_version_detail_nozero_dt_t;
alter table db_boss.t_r_app_version_detail_nozero_dt_tmp rename to db_boss.t_r_app_version_detail_nozero_dt;
alter table db_boss.t_r_app_version_detail_nozero_dt_t rename to db_boss.t_r_app_version_detail_nozero_dt_tmp;
					





CREATE TABLE `dt_1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `center` varchar(128) NOT NULL COMMENT '中心',
  `owner` varchar(1000) NOT NULL COMMENT '处理人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='各个中心对应的责任人';

CREATE TABLE `dt_tmp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `center` varchar(128) NOT NULL COMMENT '中心',
  `owner` varchar(1000) NOT NULL COMMENT '处理人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='各个中心对应的责任人';


create user 'rename_user'@'%' identified by '123456abc';
grant INSERT, CREATE, alter,drop on sbtest.dt_1 to 'rename_user'@'%' with grant option;
grant INSERT, CREATE, alter,drop on sbtest.dt_tmp to 'rename_user'@'%' with grant option;
grant INSERT, CREATE, alter,drop on sbtest.dt_t to 'rename_user'@'%' with grant option;


alter table dt_1 rename to dt_t;
alter table dt_tmp rename to dt_1;
alter table dt_t rename to dt_tmp;





