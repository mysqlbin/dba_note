

drop table if exists t_20220614 ;
CREATE TABLE `t_20220614` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键ID',
  `app_id` varchar(64) NOT NULL DEFAULT '0' COMMENT '店铺id',
  PRIMARY KEY (`id`),
  unique key uni_app_id(`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='t_20220614';



mysql> select * from t_20220614;
+----+--------+
| id | app_id |
+----+--------+
|  1 | 1      |
+----+--------+
1 row in set (0.00 sec)

mysql> show create table t_20220614;
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table      | Create Table                                                                                                                                                                                                                                                                                             |
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| t_20220614 | CREATE TABLE `t_20220614` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键ID',
  `app_id` varchar(64) NOT NULL DEFAULT '0' COMMENT '店铺id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_app_id` (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='t_20220614'       |
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)




mysql -h 101.37.253.14 -ucode_viewer -p'@123456Abc.'  sbtest -f < 2022-06-14.sql 

[root@iZbp1co0b2dkojjkbk7r8cZ ~]# mysql -h 101.37.253.14 -ucode_viewer -p'@123456Abc.'  sbtest -f < 2022-06-14.sql 
mysql: [Warning] Using a password on the command line interface can be insecure.
ERROR 1062 (23000) at line 5: Duplicate entry '1' for key 'uni_app_id'


mysql> select * from t_20220614;
+----+--------+
| id | app_id |
+----+--------+
|  1 | 1      |
|  2 | 2      |
|  3 | 3      |
+----+--------+
3 rows in set (0.00 sec)

