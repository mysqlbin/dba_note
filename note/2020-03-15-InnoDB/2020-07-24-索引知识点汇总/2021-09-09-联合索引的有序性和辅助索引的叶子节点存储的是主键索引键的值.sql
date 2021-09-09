
1. 初始化表结构和数据
2. 二级索引idx_name_age 的组织顺序如下
3. 验证联合索引的有序性
4. 验证辅助索引 idx_name_age的叶子节点存储的是主键值
4.1 方式1
4.2 方式2 
4.3 方式3

1. 初始化表结构和数据
	
	drop table tuser;
	CREATE TABLE `tuser` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
	  `name` varchar(32) not NULL default '',
	  `age` int(11) not NULL,
	  `ismale` tinyint(1) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_name_age` (`name`,`age`)
	) ENGINE=InnoDB;


	INSERT INTO `base_db`.`tuser` (`id`, `name`, `age`, `ismale`) VALUES ('1', '张六', '30', NULL);
	INSERT INTO `base_db`.`tuser` (`id`, `name`, `age`, `ismale`) VALUES ('2', '张三', '10', NULL);
	INSERT INTO `base_db`.`tuser` (`id`, `name`, `age`, `ismale`) VALUES ('3', '张三', '10', NULL);
	INSERT INTO `base_db`.`tuser` (`id`, `name`, `age`, `ismale`) VALUES ('4', '张三', '20', NULL);
	INSERT INTO `base_db`.`tuser` (`id`, `name`, `age`, `ismale`) VALUES ('5', '李四', '20', NULL);
	INSERT INTO `base_db`.`tuser` (`id`, `name`, `age`, `ismale`) VALUES ('6', '王五', '10', NULL);

	mysql> select * from tuser;
	+----+--------+-----+--------+
	| id | name   | age | ismale |
	+----+--------+-----+--------+
	|  1 | 张六   |  30 |   NULL |
	|  2 | 张三   |  10 |   NULL |
	|  3 | 张三   |  10 |   NULL |
	|  4 | 张三   |  20 |   NULL |
	|  5 | 李四   |  20 |   NULL |
	|  6 | 王五   |  10 |   NULL |
	+----+--------+-----+--------+
	6 rows in set (0.00 sec)


2. 二级索引idx_name_age 的组织顺序如下

	mysql> select name,age,id from tuser order by name asc,age asc, id asc;
	+--------+-----+----+
	| name   | age | id |
	+--------+-----+----+
	| 张三   |  10 |  2 |
	| 张三   |  10 |  3 |
	| 张三   |  20 |  4 |
	| 张六   |  30 |  1 |
	| 李四   |  20 |  5 |
	| 王五   |  10 |  6 |
	+--------+-----+----+
	6 rows in set (0.00 sec)

	shell> innodb_space -s ibdata1 -T base_db/tuser -I idx_name_age index-recurse
	ROOT NODE #5: 6 records, 120 bytes
	  RECORD: (name="张三", age=10) → (id=2)
	  RECORD: (name="张三", age=10) → (id=3)
	  RECORD: (name="张三", age=20) → (id=4)
	  RECORD: (name="张六", age=30) → (id=1)
	  RECORD: (name="李四", age=20) → (id=5)
	  RECORD: (name="王五", age=10) → (id=6)
  
	索引 idx_name_age 的组织顺序相当于 order by name asc,age asc,id asc; 即先按 name 排序，然后再按 age 排序, 最后按 id 排序。 
	
	先按照name列的值进行排序。
	如果name列的值相同，则按照age列的值进行排序。
	如果age列的值也相同，则按照id的值进行排序。
	
	
	
3. 验证联合索引的有序性
	
	mysql> desc select name,age,id from tuser order by name asc,age asc, id asc;
	+----+-------------+-------+------------+-------+---------------+--------------+---------+------+------+----------+-------------+
	| id | select_type | table | partitions | type  | possible_keys | key          | key_len | ref  | rows | filtered | Extra       |
	+----+-------------+-------+------------+-------+---------------+--------------+---------+------+------+----------+-------------+
	|  1 | SIMPLE      | tuser | NULL       | index | NULL          | idx_name_age | 134     | NULL |    6 |   100.00 | Using index |
	+----+-------------+-------+------------+-------+---------------+--------------+---------+------+------+----------+-------------+
	1 row in set, 1 warning (0.02 sec)
	-- 不需要排序。
		
		
	mysql> desc select name,age,id from tuser order by name asc,id asc, age asc;
	+----+-------------+-------+------------+-------+---------------+--------------+---------+------+------+----------+-----------------------------+
	| id | select_type | table | partitions | type  | possible_keys | key          | key_len | ref  | rows | filtered | Extra                       |
	+----+-------------+-------+------------+-------+---------------+--------------+---------+------+------+----------+-----------------------------+
	|  1 | SIMPLE      | tuser | NULL       | index | NULL          | idx_name_age | 134     | NULL |    6 |   100.00 | Using index; Using filesort |
	+----+-------------+-------+------------+-------+---------------+--------------+---------+------+------+----------+-----------------------------+
	1 row in set, 1 warning (0.00 sec)
	-- 需要排序
		
	mysql> desc select * from tuser where name='张三' and age=10 order by id desc;
	+----+-------------+-------+------------+------+---------------+--------------+---------+-------------+------+----------+-------------+
	| id | select_type | table | partitions | type | possible_keys | key          | key_len | ref         | rows | filtered | Extra       |
	+----+-------------+-------+------------+------+---------------+--------------+---------+-------------+------+----------+-------------+
	|  1 | SIMPLE      | tuser | NULL       | ref  | idx_name_age  | idx_name_age | 134     | const,const |    2 |   100.00 | Using where |
	+----+-------------+-------+------------+------+---------------+--------------+---------+-------------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)
	-- 不需要排序。
	
	
4. 验证辅助索引 idx_name_age的叶子节点存储的是主键值
4.1 方式1
	mysql>  select * from mysql.innodb_index_stats where table_name='tuser';
	+---------------+------------+--------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name   | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+--------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| base_db       | tuser      | PRIMARY      | 2020-07-24 11:41:43 | n_diff_pfx01 |          6 |           1 | id                                |
	| base_db       | tuser      | PRIMARY      | 2020-07-24 11:41:43 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| base_db       | tuser      | PRIMARY      | 2020-07-24 11:41:43 | size         |          1 |        NULL | Number of pages in the index      |
	| base_db       | tuser      | idx_name_age | 2020-07-24 11:42:34 | n_diff_pfx01 |          3 |           1 | name                              |
	| base_db       | tuser      | idx_name_age | 2020-07-24 11:42:34 | n_diff_pfx02 |          5 |           1 | name,age                          |
	| base_db       | tuser      | idx_name_age | 2020-07-24 11:42:34 | n_diff_pfx03 |          6 |           1 | name,age,id                       |
	| base_db       | tuser      | idx_name_age | 2020-07-24 11:42:34 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| base_db       | tuser      | idx_name_age | 2020-07-24 11:42:34 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+--------------+---------------------+--------------+------------+-------------+-----------------------------------+
	8 rows in set (0.08 sec)

4.2 方式2 
	
	分析辅助索引 idx_name_age
	shell> innodb_space -s ibdata1 -T base_db/tuser -I idx_name_age index-recurse
	ROOT NODE #5: 6 records, 120 bytes
	  RECORD: (name="张三", age=10) → (id=2)
	  RECORD: (name="张三", age=10) → (id=3)
	  RECORD: (name="张三", age=20) → (id=4)
	  RECORD: (name="张六", age=30) → (id=1)
	  RECORD: (name="李四", age=20) → (id=5)
	  RECORD: (name="王五", age=10) → (id=6)

4.3 方式3
	
	即 验证联合索引的有序性
	mysql> desc select name,age,id from tuser order by name asc,age asc, id asc;
	+----+-------------+-------+------------+-------+---------------+--------------+---------+------+------+----------+-------------+
	| id | select_type | table | partitions | type  | possible_keys | key          | key_len | ref  | rows | filtered | Extra       |
	+----+-------------+-------+------------+-------+---------------+--------------+---------+------+------+----------+-------------+
	|  1 | SIMPLE      | tuser | NULL       | index | NULL          | idx_name_age | 134     | NULL |    6 |   100.00 | Using index |
	+----+-------------+-------+------------+-------+---------------+--------------+---------+------+------+----------+-------------+
	1 row in set, 1 warning (0.02 sec)
	