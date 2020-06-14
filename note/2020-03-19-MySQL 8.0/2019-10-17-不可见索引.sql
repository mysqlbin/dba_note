
1. 为什么需要不可见索引
2. 初始化表结构和测试不可见索引
3. 关于invisible index的几点补充
4. 相关参考


1. 为什么需要不可见索引
	当我们发现冗余索引或者个别不再需要的索引时，首先想到的是直接删除。

	但是直接删除索引肯定是有风险的，难免什么时候某个老业务又需要用到这个索引了，这时候invisible index就非常实用了。

	这时候就可以把这个索引设置为 visible/invisible，修改索引的 visible 属性是可以in-place的，非常快。这相比删除、再次创建索引要快得多了。

	
2. 初始化表结构和测试不可见索引
	CREATE TABLE `t4` (
	  `id` int(11) NOT NULL,
	  `a` int(11) DEFAULT NULL,
	  `b` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `a` (`a`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

	mysql> select count(*) from t4;
	+----------+
	| count(*) |
	+----------+
	|  1000000 |
	+----------+
	1 row in set (0.10 sec)

	# 把索引设置为不可见
		mysql> alter table t4 alter index a invisible;
		Query OK, 0 rows affected (0.04 sec)
		Records: 0  Duplicates: 0  Warnings: 0

	# 查看表结构
		mysql> show create table t4\G;
		CREATE TABLE `t4` (
		  `id` int(11) NOT NULL,
		  `a` int(11) DEFAULT NULL,
		  `b` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `a` (`a`) /*!80000 INVISIBLE */
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
	
	# 试着指定索引:
		mysql> select * from t4 force index (`a`) where a=1;
		" ERROR 1176 (42000): Key 'a' doesn't exist in table t4 "
	
	# 查看索引基数
		mysql> show index from t4;
		+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
		| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
		+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
		| t4    |          0 | PRIMARY  |            1 | id          | A         |      998222 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
		| t4    |          1 | a        |            1 | a           | A         |      998222 |     NULL |   NULL | YES  | BTREE      |         |               | NO      | NULL       |
		+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
		2 rows in set (0.01 sec)

	# 查看索引状态
		mysql> select index_name,is_visible from information_schema.statistics where table_name = 't4';
		+------------+------------+
		| INDEX_NAME | IS_VISIBLE |
		+------------+------------+
		| a          | NO         |
		| PRIMARY    | YES        |
		+------------+------------+
		2 rows in set (0.00 sec)
		
	
	# 把索引设置为可见
		mysql> alter table t4 alter index a visible;
		Query OK, 0 rows affected (0.10 sec)
		Records: 0  Duplicates: 0  Warnings: 0

	# 查看索引状态
		mysql> select index_name,is_visible from information_schema.statistics where table_name = 't4';
		+------------+------------+
		| INDEX_NAME | IS_VISIBLE |
		+------------+------------+
		| a          | YES        |
		| PRIMARY    | YES        |
		+------------+------------+
		2 rows in set (0.00 sec)

		
3. 关于invisible index的几点补充

	1. 即便是 invisible，也还要保持索引的更新；

	2. 主键或被选中作为聚集索引的唯一索引（这种称为隐含的聚集索引），都不能 invisible；

	3. 任何存储引擎都支持，不仅限于InnoDB；	
	

4. 相关参考
	https://yq.aliyun.com/articles/61287 (MySQL · 8.0新特性· Invisible Index)
	https://mp.weixin.qq.com/s/XQHzTY0q9xZ8B_c8xlComg   (老斯基带你解锁MySQL 8.0索引新姿势)
	