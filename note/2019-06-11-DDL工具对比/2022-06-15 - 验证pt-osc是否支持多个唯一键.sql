
CREATE TABLE `t_r_learn_center_m_8` (
`id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
`month_date` varchar(64) NOT NULL COMMENT '日期(月的第一天)',
`app_id` varchar(64) NOT NULL COMMENT '店铺id',
`user_id` varchar(64) NOT NULL COMMENT '用户id',
`learn_num` int(11) NOT NULL DEFAULT '0' COMMENT '本月完成课程',
`learn_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '本月学习时长 单位秒',
`last_learn_time` varchar(32) DEFAULT NULL COMMENT '本月最晚学习时间',
`learn_days` tinyint(4) NOT NULL DEFAULT '0' COMMENT '本月学习天数',
`state` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0正常 1删除',
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
PRIMARY KEY (`id`),
UNIQUE KEY `idx_unique` (`app_id`, `month_date`, `user_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 11318256 DEFAULT CHARSET = utf8mb4 COMMENT = '用户学习月报表（表名按app_id最后一位进行分表）按月分区';


alter table t_r_learn_center_m_8 add unique idx_unique_new (app_id, user_id, month_date);
	
mysql> alter table t_r_learn_center_m_8 add unique idx_unique_new (app_id, user_id, month_date);
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0


mysql> show create table t_r_learn_center_m_8\G;
*************************** 1. row ***************************
       Table: t_r_learn_center_m_8
Create Table: CREATE TABLE `t_r_learn_center_m_8` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `month_date` varchar(64) NOT NULL COMMENT '日期(月的第一天)',
  `app_id` varchar(64) NOT NULL COMMENT '店铺id',
  `user_id` varchar(64) NOT NULL COMMENT '用户id',
  `learn_num` int(11) NOT NULL DEFAULT '0' COMMENT '本月完成课程',
  `learn_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '本月学习时长 单位秒',
  `last_learn_time` varchar(32) DEFAULT NULL COMMENT '本月最晚学习时间',
  `learn_days` tinyint(4) NOT NULL DEFAULT '0' COMMENT '本月学习天数',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0正常 1删除',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique` (`app_id`,`month_date`,`user_id`),
  UNIQUE KEY `idx_unique_new` (`app_id`,`user_id`,`month_date`)
) ENGINE=InnoDB AUTO_INCREMENT=11318256 DEFAULT CHARSET=utf8mb4 COMMENT='用户学习月报表（表名按app_id最后一位进行分表）按月分区'
1 row in set (0.00 sec)


--------------------------------------------------------------------------------------------------------------------------------------

mysql> show create table t_r_learn_center_m_8\G;
*************************** 1. row ***************************
       Table: t_r_learn_center_m_8
Create Table: CREATE TABLE `t_r_learn_center_m_8` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `month_date` varchar(64) NOT NULL COMMENT '日期(月的第一天)',
  `app_id` varchar(64) NOT NULL COMMENT '店铺id',
  `user_id` varchar(64) NOT NULL COMMENT '用户id',
  `learn_num` int(11) NOT NULL DEFAULT '0' COMMENT '本月完成课程',
  `learn_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '本月学习时长 单位秒',
  `last_learn_time` varchar(32) DEFAULT NULL COMMENT '本月最晚学习时间',
  `learn_days` tinyint(4) NOT NULL DEFAULT '0' COMMENT '本月学习天数',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0正常 1删除',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique` (`app_id`,`month_date`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11318256 DEFAULT CHARSET=utf8mb4 COMMENT='用户学习月报表（表名按app_id最后一位进行分表）按月分区'
1 row in set (0.00 sec)


pt-online-schema-change --chunk-size-limit=20000 --no-check-replication-filters  --charset=utf8mb4 --execute --alter "add unique idx_unique_new (app_id, user_id, month_date)" --user=code_viewer --password='@123456Abc.' --host=101.37.253.14 D=sbtest,t=t_r_learn_center_m_8


[root@VM-0-110-centos ~]# pt-online-schema-change --chunk-size-limit=20000 --no-check-replication-filters  --charset=utf8mb4 --execute --alter "add unique idx_unique_new (app_id, user_id, month_date)" --user=code_viewer --password='@123456Abc.' --host=101.37.253.14 D=sbtest,t=t_r_learn_center_m_8
No slaves found.  See --recursion-method if host iZbp1co0b2dkojjkbk7r8cZ has slaves.
Not checking slave lag because no slaves were found and --check-slave-lag was not specified.
Operation, tries, wait:
  analyze_table, 10, 1
  copy_rows, 10, 0.25
  create_triggers, 10, 1
  drop_triggers, 10, 1
  swap_tables, 10, 1
  update_foreign_keys, 10, 1
Altering `sbtest`.`t_r_learn_center_m_8`...
You are trying to add an unique key. This can result in data loss if the data is not unique.
Please read the documentation for the --check-unique-key-change parameter.
You can check if the column(s) contain duplicate content by running this/these query/queries:

SELECT IF(COUNT(DISTINCT app_id, user_id, month_date) = COUNT(*),
       'Yes, the desired unique index currently contains only unique values', 
       'No, the desired unique index contains duplicated values. There will be data loss'
) AS IsThereUniqueness FROM `sbtest`.`t_r_learn_center_m_8`;

Keep in mind that these queries could take a long time and consume a lot of resources

`sbtest`.`t_r_learn_center_m_8` was not altered.

mysql> show create table t_r_learn_center_m_8\G;
*************************** 1. row ***************************
       Table: t_r_learn_center_m_8
Create Table: CREATE TABLE `t_r_learn_center_m_8` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `month_date` varchar(64) NOT NULL COMMENT '日期(月的第一天)',
  `app_id` varchar(64) NOT NULL COMMENT '店铺id',
  `user_id` varchar(64) NOT NULL COMMENT '用户id',
  `learn_num` int(11) NOT NULL DEFAULT '0' COMMENT '本月完成课程',
  `learn_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '本月学习时长 单位秒',
  `last_learn_time` varchar(32) DEFAULT NULL COMMENT '本月最晚学习时间',
  `learn_days` tinyint(4) NOT NULL DEFAULT '0' COMMENT '本月学习天数',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0正常 1删除',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique` (`app_id`,`month_date`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11318256 DEFAULT CHARSET=utf8mb4 COMMENT='用户学习月报表（表名按app_id最后一位进行分表）按月分区'
1 row in set (0.00 sec)
