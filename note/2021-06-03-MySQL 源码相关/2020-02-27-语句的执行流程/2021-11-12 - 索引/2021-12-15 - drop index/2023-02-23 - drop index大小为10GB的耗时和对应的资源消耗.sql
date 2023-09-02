



nohup sysbench --db-driver=mysql --mysql-host= --mysql-port=3306 --mysql-user=root --mysql-password= --mysql-db=db_slowlog --table_size=2000000000 --tables=2 oltp_read_write prepare &


机器配置：
		
	通用型-4核8000MB内存，500GB存储空间
	最大 IOPS：8000
	
MySQL [db_slowlog]> show create table t_sql_slowlog_record_detail\G;
*************************** 1. row ***************************
       Table: t_sql_slowlog_record_detail
Create Table: CREATE TABLE `t_sql_slowlog_record_detail` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `database` varchar(32) NOT NULL COMMENT '数据库名称',
  `instance_id` varchar(32) NOT NULL COMMENT '实例id',
  `sql_template` longtext NOT NULL COMMENT '慢日志模板',
  `sql_text` longtext NOT NULL COMMENT '慢sql例子',
  `mysql_user` varchar(128) NOT NULL COMMENT 'mysql用户',
  `sql_execute_time` float DEFAULT NULL COMMENT '执行时长',
  `locktime` float DEFAULT NULL COMMENT '持有锁的时长',
  `rowsexamined` bigint(20) DEFAULT NULL COMMENT '扫描行数',
  `rowssent` bigint(20) DEFAULT NULL COMMENT '结果集行数',
  `user_host` varchar(32) NOT NULL COMMENT 'ip',
  `start_time` datetime(6) NOT NULL COMMENT '开始时间',
  `end_time` datetime(6) NOT NULL COMMENT '结束时间',
  `environment` int(11) DEFAULT NULL COMMENT '环境',
  `timestamps` bigint(11) NOT NULL COMMENT '执行时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `instance_name` varchar(256) NOT NULL DEFAULT '' COMMENT '实例名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48487109 DEFAULT CHARSET=utf8mb4 COMMENT='慢日志明细表'
1 row in set (0.00 sec)


alter table t_sql_slowlog_record_detail add index idx_sql_text(`sql_text`);
alter table t_sql_slowlog_record_detail add index idx_sql_text(`sql_text`(2000));


MySQL [db_slowlog]> alter table t_sql_slowlog_record_detail add index idx_sql_text(`sql_text`);
ERROR 1170 (42000): BLOB/TEXT column 'sql_text' used in key specification without a key length

MySQL [db_slowlog]> alter table t_sql_slowlog_record_detail add index idx_sql_text(`sql_text`(2000));
Query OK, 0 rows affected, 1 warning (31 min 49.65 sec)
Records: 0  Duplicates: 0  Warnings: 1



MySQL [db_slowlog]> show create table t_sql_slowlog_record_detail\G;
*************************** 1. row ***************************
       Table: t_sql_slowlog_record_detail
Create Table: CREATE TABLE `t_sql_slowlog_record_detail` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `database` varchar(32) NOT NULL COMMENT '数据库名称',
  `instance_id` varchar(32) NOT NULL COMMENT '实例id',
  `sql_template` longtext NOT NULL COMMENT '慢日志模板',
  `sql_text` longtext NOT NULL COMMENT '慢sql例子',
  `mysql_user` varchar(128) NOT NULL COMMENT 'mysql用户',
  `sql_execute_time` float DEFAULT NULL COMMENT '执行时长',
  `locktime` float DEFAULT NULL COMMENT '持有锁的时长',
  `rowsexamined` bigint(20) DEFAULT NULL COMMENT '扫描行数',
  `rowssent` bigint(20) DEFAULT NULL COMMENT '结果集行数',
  `user_host` varchar(32) NOT NULL COMMENT 'ip',
  `start_time` datetime(6) NOT NULL COMMENT '开始时间',
  `end_time` datetime(6) NOT NULL COMMENT '结束时间',
  `environment` int(11) DEFAULT NULL COMMENT '环境',
  `timestamps` bigint(11) NOT NULL COMMENT '执行时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `instance_name` varchar(256) NOT NULL DEFAULT '' COMMENT '实例名称',
  PRIMARY KEY (`id`),
  KEY `idx_sql_text` (`sql_text`(768))
) ENGINE=InnoDB AUTO_INCREMENT=48487109 DEFAULT CHARSET=utf8mb4 COMMENT='慢日志明细表'
1 row in set (0.00 sec)

ERROR: No query specified



analyze table t_sql_slowlog_record_detail;

SELECT 
   DATA_LENGTH / (1024 * 1024 * 1024) AS 'DATA_SIZE(GB)', 
   INDEX_LENGTH / (1024 * 1024 * 1024) AS 'INDEX_SIZE(GB)', 
   TABLE_SCHEMA, 
   TABLE_NAME
FROM information_schema.TABLES
WHERE TABLE_NAME = 't_sql_slowlog_record_detail';




MySQL [db_slowlog]> analyze table t_sql_slowlog_record_detail;

+----------------------------------------+---------+----------+----------+
| Table                                  | Op      | Msg_type | Msg_text |
+----------------------------------------+---------+----------+----------+
| db_slowlog.t_sql_slowlog_record_detail | analyze | status   | OK       |
+----------------------------------------+---------+----------+----------+
1 row in set (0.03 sec)


MySQL [db_slowlog]> SELECT     DATA_LENGTH / (1024 * 1024 * 1024) AS 'DATA_SIZE(GB)',     INDEX_LENGTH / (1024 * 1024 * 1024) AS 'INDEX_SIZE(GB)',     TABLE_SCHEMA,     TABLE_NAME FROM information_schema.TABLES WHERE TABLE_NAME = 't_sql_slowlog_record_detail';
+---------------+----------------+--------------+-----------------------------+
| DATA_SIZE(GB) | INDEX_SIZE(GB) | TABLE_SCHEMA | TABLE_NAME                  |
+---------------+----------------+--------------+-----------------------------+
|      102.1640 |        16.0127 | db_slowlog   | t_sql_slowlog_record_detail |
+---------------+----------------+--------------+-----------------------------+
1 row in set (0.00 sec)


alter table t_sql_slowlog_record_detail drop index idx_sql_text;


MySQL [db_slowlog]> alter table t_sql_slowlog_record_detail drop index idx_sql_text;
Query OK, 0 rows affected (0.23 sec)
Records: 0  Duplicates: 0  Warnings: 0



-- cpu利用率、IO利用率（IOPS）没有变化；
















