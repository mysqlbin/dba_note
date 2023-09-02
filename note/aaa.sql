

root@mysqldb 07:24:  [(none)]> select version();
+------------+
| version()  |
+------------+
| 5.7.21-log |
+------------+
1 row in set (0.00 sec)

root@mysqldb 07:24:  [(none)]> show global variables like '%sql_mode%';
+---------------+--------------------------------------------+
| Variable_name | Value                                      |
+---------------+--------------------------------------------+
| sql_mode      | STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION |
+---------------+--------------------------------------------+
1 row in set (0.00 sec)

mysql> show global variables like '%explicit_defaults_for_timestamp%';
+---------------------------------+--------+
| Variable_name                   | Value |
+---------------------------------+--------+
| explicit_defaults_for_timestamp | OFF    |
+---------------------------------+--------+
1 row in set (0.00 sec)

[SQL]alter table t1 add column tFinishTime timestamp DEFAULT NULL comment '任务完成时间';
[Err] 1067 - Invalid default value for 'tFinishTime'
	-- 无效的默认值

[SQL]alter table t1 add column tFinishTime timestamp NULL DEFAULT NULL comment '任务完成时间';
-- OK

--------------------------------------------------------------------------------------------------------------

root@mysqldb 07:24:  [(none)]> select version();
+------------+
| version()  |
+------------+
| 5.7.22-log |
+------------+
1 row in set (0.00 sec)

root@mysqldb 07:24:  [(none)]> show global variables like '%sql_mode%';
+---------------+--------------------------------------------+
| Variable_name | Value                                      |
+---------------+--------------------------------------------+
| sql_mode      | STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION |
+---------------+--------------------------------------------+
1 row in set (0.00 sec)


root@mysqldb 07:28:  [audit_Db]> show global variables like '%explicit_defaults_for_timestamp%';
+---------------------------------+-------+
| Variable_name                   | Value |
+---------------------------------+-------+
| explicit_defaults_for_timestamp | ON    |
+---------------------------------+-------+
1 row in set (0.00 sec)


DROP TABLE IF EXISTS  t1;

CREATE TABLE `t1` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_c` (`c`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;


alter table t1 add column tFinishTime timestamp DEFAULT NULL comment '任务完成时间';
Query OK, 0 rows affected (0.23 sec)
Records: 0  Duplicates: 0  Warnings: 0



root@mysqldb 07:28:  [audit_Db]> show create table t1\G;
*************************** 1. row ***************************
       Table: t1
Create Table: CREATE TABLE `t1` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  `tFinishTime` timestamp NULL DEFAULT NULL COMMENT '任务完成时间',
  PRIMARY KEY (`id`),
  KEY `idx_c` (`c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
1 row in set (0.00 sec)
