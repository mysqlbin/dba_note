

测试1 

	drop table  if exists t_0529;
	CREATE TABLE `t_0529` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键ID',
	  `app_id` varchar(64) NOT NULL DEFAULT '0' COMMENT '店铺id',
	  `resource_type` bigint(20) NOT NULL DEFAULT '0' COMMENT '店铺id',
	  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='dba_test_table';


	INSERT INTO `test_db`.`t_0529` (`app_id`, `resource_type`, `created_at`) VALUES ('1', '2', "2022-05-29 00:00:02");
	INSERT INTO `test_db`.`t_0529` (`app_id`, `resource_type`, `created_at`) VALUES ('1', '2', "2022-05-29 00:00:01");
	INSERT INTO `test_db`.`t_0529` (`app_id`, `resource_type`, `created_at`) VALUES ('2', '1', "2022-05-29 00:00:01");
	INSERT INTO `test_db`.`t_0529` (`app_id`, `resource_type`, `created_at`) VALUES ('2', '1', "2022-05-29 00:00:01");
	INSERT INTO `test_db`.`t_0529` (`app_id`, `resource_type`, `created_at`) VALUES ('2', '1', "2022-05-29 00:00:01");
	INSERT INTO `test_db`.`t_0529` (`app_id`, `resource_type`, `created_at`) VALUES ('2', '1', "2022-05-29 00:00:01");
	INSERT INTO `test_db`.`t_0529` (`app_id`, `resource_type`, `created_at`) VALUES ('2', '1', "2022-05-29 00:00:01");
	INSERT INTO `test_db`.`t_0529` (`app_id`, `resource_type`, `created_at`) VALUES ('2', '1', "2022-05-29 00:00:01");
	INSERT INTO `test_db`.`t_0529` (`app_id`, `resource_type`, `created_at`) VALUES ('2', '1', "2022-05-29 00:00:01");
	INSERT INTO `test_db`.`t_0529` (`app_id`, `resource_type`, `created_at`) VALUES ('2', '1', "2022-05-29 00:00:01");
	INSERT INTO `test_db`.`t_0529` (`app_id`, `resource_type`, `created_at`) VALUES ('2', '1', "2022-05-29 00:00:01");
	INSERT INTO `test_db`.`t_0529` (`app_id`, `resource_type`, `created_at`) VALUES ('2', '1', "2022-05-29 00:00:01");


	alter table t_0529 add index idx_app_id_resource_type_created_at(`app_id`,`resource_type`,`created_at`);

	mysql> desc select * from t_0529 where app_id=1 and resource_type=2 order by created_at desc limit 1;
	+----+-------------+--------+------------+-------+-------------------------------------+-------------------------------------+---------+------+------+----------+------------------------------------------+
	| id | select_type | table  | partitions | type  | possible_keys                       | key                                 | key_len | ref  | rows | filtered | Extra                                    |
	+----+-------------+--------+------------+-------+-------------------------------------+-------------------------------------+---------+------+------+----------+------------------------------------------+
	|  1 | SIMPLE      | t_0529 | NULL       | index | idx_app_id_resource_type_created_at | idx_app_id_resource_type_created_at | 271     | NULL |   12 |     8.33 | Using where; Using index; Using filesort |
	+----+-------------+--------+------------+-------+-------------------------------------+-------------------------------------+---------+------+------+----------+------------------------------------------+
	1 row in set, 3 warnings (0.00 sec)


	mysql> select * from t_0529 where app_id=1 and resource_type=2 order by created_at desc limit 1;
	+----+--------+---------------+---------------------+
	| id | app_id | resource_type | created_at          |
	+----+--------+---------------+---------------------+
	|  1 | 1      |             2 | 2022-05-29 00:00:02 |
	+----+--------+---------------+---------------------+
	1 row in set (0.00 sec)


	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


	mysql> desc select * from t_0529 where app_id=1 and resource_type=2 order by app_id desc,resource_type desc,created_at desc limit 1;
	+----+-------------+--------+------------+-------+-------------------------------------+-------------------------------------+---------+------+------+----------+--------------------------+
	| id | select_type | table  | partitions | type  | possible_keys                       | key                                 | key_len | ref  | rows | filtered | Extra                    |
	+----+-------------+--------+------------+-------+-------------------------------------+-------------------------------------+---------+------+------+----------+--------------------------+
	|  1 | SIMPLE      | t_0529 | NULL       | index | idx_app_id_resource_type_created_at | idx_app_id_resource_type_created_at | 271     | NULL |    1 |     8.33 | Using where; Using index |
	+----+-------------+--------+------------+-------+-------------------------------------+-------------------------------------+---------+------+------+----------+--------------------------+
	1 row in set, 3 warnings (0.00 sec)


	mysql> select * from t_0529 where app_id=1 and resource_type=2 order by app_id desc,resource_type desc,created_at desc limit 1;
	+----+--------+---------------+---------------------+
	| id | app_id | resource_type | created_at          |
	+----+--------+---------------+---------------------+
	|  1 | 1      |             2 | 2022-05-29 00:00:02 |
	+----+--------+---------------+---------------------+
	1 row in set (0.00 sec)



测试2：

	多插入一行记录
	
	
	INSERT INTO `test_db`.`t_0529` (`app_id`, `resource_type`, `created_at`) VALUES ('1', '2', "2022-05-29 00:00:03");
	
	mysql> select * from t_0529 where app_id=1 and resource_type=2;
	+----+--------+---------------+---------------------+
	| id | app_id | resource_type | created_at          |
	+----+--------+---------------+---------------------+
	|  2 | 1      |             2 | 2022-05-29 00:00:01 |
	|  1 | 1      |             2 | 2022-05-29 00:00:02 |
	| 13 | 1      |             2 | 2022-05-29 00:00:03 |
	+----+--------+---------------+---------------------+
	3 rows in set (0.00 sec)



	mysql> select * from t_0529 where app_id=1 and resource_type=2 order by app_id desc,resource_type desc,created_at desc limit 1;
	+----+--------+---------------+---------------------+
	| id | app_id | resource_type | created_at          |
	+----+--------+---------------+---------------------+
	| 13 | 1      |             2 | 2022-05-29 00:00:03 |
	+----+--------+---------------+---------------------+
	1 row in set (0.00 sec)


	mysql> select * from t_0529 where app_id=1 and resource_type=2 order by created_at desc limit 1;
	+----+--------+---------------+---------------------+
	| id | app_id | resource_type | created_at          |
	+----+--------+---------------+---------------------+
	| 13 | 1      |             2 | 2022-05-29 00:00:03 |
	+----+--------+---------------+---------------------+
	1 row in set (0.00 sec)


测试3：

	再多插入一行记录
	
	
	INSERT INTO `test_db`.`t_0529` (`app_id`, `resource_type`, `created_at`) VALUES ('1', '2', "2022-05-29 00:00:00");
	
	mysql> select * from t_0529 where app_id=1 and resource_type=2;
	+----+--------+---------------+---------------------+
	| id | app_id | resource_type | created_at          |
	+----+--------+---------------+---------------------+
	| 14 | 1      |             2 | 2022-05-29 00:00:00 |
	|  2 | 1      |             2 | 2022-05-29 00:00:01 |
	|  1 | 1      |             2 | 2022-05-29 00:00:02 |
	| 13 | 1      |             2 | 2022-05-29 00:00:03 |
	+----+--------+---------------+---------------------+
	4 rows in set (0.00 sec)

		
	mysql> select * from t_0529 where app_id=1 and resource_type=2 order by app_id desc,resource_type desc,created_at desc limit 1;
	+----+--------+---------------+---------------------+
	| id | app_id | resource_type | created_at          |
	+----+--------+---------------+---------------------+
	| 13 | 1      |             2 | 2022-05-29 00:00:03 |
	+----+--------+---------------+---------------------+
	1 row in set (0.00 sec)

	mysql> select * from t_0529 where app_id=1 and resource_type=2 order by created_at desc limit 1;
	+----+--------+---------------+---------------------+
	| id | app_id | resource_type | created_at          |
	+----+--------+---------------+---------------------+
	| 13 | 1      |             2 | 2022-05-29 00:00:03 |
	+----+--------+---------------+---------------------+
	1 row in set (0.00 sec)
	
	
我的问题：

	这2条sql语句，语义是一样的吗
	我觉得是一样的。查询出来得到的结果是一样的。
	
	
这里主要是利用了索引的有序性进行了sql优化。



