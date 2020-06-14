

desc select * from tuser where name='123';
desc select * from tuser force index(`idx_name`) where name='123';
desc select * from tuser where name='123' and age=3;


CREATE TABLE `tuser` (
  `id` int(11) NOT NULL,
  `id_card` varchar(32) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `ismale` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_card` (`id_card`),
  KEY `idx_name_age` (`name`,`age`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
1 row in set (0.00 sec)

mysql> desc select * from tuser where name='123';
+----+-------------+-------+------+-----------------------+--------------+---------+-------+------+-----------------------+
| id | select_type | table | type | possible_keys         | key          | key_len | ref   | rows | Extra                 |
+----+-------------+-------+------+-----------------------+--------------+---------+-------+------+-----------------------+
|  1 | SIMPLE      | tuser | ref  | idx_name_age,idx_name | idx_name_age | 131     | const |    1 | Using index condition |
+----+-------------+-------+------+-----------------------+--------------+---------+-------+------+-----------------------+
1 row in set (0.01 sec)
# 可以下推，实际上是 可以，但没有使用索引下推优化

mysql> desc select * from tuser force index(`idx_name`) where name='123';
+----+-------------+-------+------+---------------+----------+---------+-------+------+-----------------------+
| id | select_type | table | type | possible_keys | key      | key_len | ref   | rows | Extra                 |
+----+-------------+-------+------+---------------+----------+---------+-------+------+-----------------------+
|  1 | SIMPLE      | tuser | ref  | idx_name      | idx_name | 131     | const |    1 | Using index condition |
+----+-------------+-------+------+---------------+----------+---------+-------+------+-----------------------+
1 row in set (0.00 sec)

mysql> desc select * from tuser where name='123' and age=3;
+----+-------------+-------+------+-----------------------+--------------+---------+-------------+------+-----------------------+
| id | select_type | table | type | possible_keys         | key          | key_len | ref         | rows | Extra                 |
+----+-------------+-------+------+-----------------------+--------------+---------+-------------+------+-----------------------+
|  1 | SIMPLE      | tuser | ref  | idx_name_age,idx_name | idx_name_age | 136     | const,const |    1 | Using index condition |
+----+-------------+-------+------+-----------------------+--------------+---------+-------------+------+-----------------------+
1 row in set (0.00 sec)

# 使用到索引下推优化


ICP是不是做得不太好,感觉很多地方没有用到索引下推,都会显示using index condition
	其实它表示的是“可以下推”，实际上是“可以，但没有”
	
 如果执行计划中的extra列的值等于ICP，但是执行计划中并没有把使用到ICP的索引列长度记录到key_len中：表示可以下推，但实际上并没有使用索引下推优化。

	

