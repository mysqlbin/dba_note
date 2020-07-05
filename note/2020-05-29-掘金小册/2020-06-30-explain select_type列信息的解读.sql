

1. explain各个列的描述
2. 表结构和数据初始化
5. select_type列
	5.1 SIMPLE
	5.2 PRIMARY
	5.3 UNION
	5.4 UNION RESULT
	5.5 SUBQUERY
	5.6 DEPENDENT SUBQUERY
	5.7 DEPENDENT UNION
	5.8 DERIVED
	5.9 MATERIALIZED
	

1. explain各个列的描述
	列名	     描述
	id	         在一个大的查询语句中每个SELECT关键字都对应一个唯一的id
	select_type	 SELECT关键字对应的那个查询的类型
	table	     表名
	partitions	 匹配的分区信息
	type	     针对单表的访问方法
	possible_keys	可能用到的索引
	key	         实际上使用的索引
	key_len	     实际使用到的索引长度
	ref	         当使用索引列等值查询时，与索引列进行等值匹配的对象信息
	rows	     预估的需要读取的记录条数
	filtered	 某个表经过搜索条件过滤后剩余记录条数的百分比
	Extra	     一些额外的信息



2. 表结构和数据初始化
	CREATE TABLE t1 (
		id INT NOT NULL AUTO_INCREMENT,
		key1 VARCHAR(100),
		key2 INT,
		key3 VARCHAR(100),
		common_field VARCHAR(100),
		PRIMARY KEY (id),
		KEY idx_key1 (key1),
		UNIQUE KEY idx_key2 (key2),
		KEY idx_key3 (key3)
	) Engine=InnoDB CHARSET=utf8mb4;

	CREATE TABLE t2 (
		id INT NOT NULL AUTO_INCREMENT,
		key1 VARCHAR(100),
		key2 INT,
		key3 VARCHAR(100),
		common_field VARCHAR(100),
		PRIMARY KEY (id),
		KEY idx_key1 (key1),
		UNIQUE KEY idx_key2 (key2),
		KEY idx_key3 (key3)
	) Engine=InnoDB CHARSET=utf8mb4;


	drop PROCEDURE idata();
	truncate table t1;
	truncate table t2;
	
	CREATE PROCEDURE `idata`()
	begin
	declare i int;
	set i=1;
	start transaction;
	while(i<=10000) do
	INSERT INTO t1 (key1, key2, key3, common_field) values (round(rand()*100), i, round(rand()*100), round(rand()*100));
	INSERT INTO t2 (key1, key2, key3, common_field) values (round(rand()*100), i, round(rand()*100), round(rand()*100));
	set i=i+1;
	end while;
	commit;
	end


	call idata();

	root@mysqldb 12:28:  [audit_db]> select count(*) from t1;
	+----------+
	| count(*) |
	+----------+
	|    10000 |
	+----------+
	1 row in set (0.00 sec)

	root@mysqldb 12:28:  [audit_db]> select count(*) from t2;
	+----------+
	| count(*) |
	+----------+
	|    10000 |
	+----------+
	1 row in set (0.00 sec)


5. select_type列
	
	每一个SELECT关键字代表的小查询都定义了一个称之为 select_type 的属性，意思是我们只要知道了某个小查询的select_type属性，就知道了这个小查询在整个大查询中扮演了一个什么角色
	
	SIMPLE
	
		查询语句中不包含UNION或者子查询的查询都算作是SIMPLE类型，比方说下边这个单表查询的select_type的值就是SIMPLE：
	
	
		root@mysqldb 15:19:  [audit_db]> EXPLAIN SELECT * FROM t1;
		+----+-------------+-------+------------+------+---------------+------+---------+------+-------+----------+-------+
		| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows  | filtered | Extra |
		+----+-------------+-------+------------+------+---------------+------+---------+------+-------+----------+-------+
		|  1 | SIMPLE      | t1    | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 10212 |   100.00 | NULL  |
		+----+-------------+-------+------------+------+---------------+------+---------+------+-------+----------+-------+
		1 row in set, 1 warning (0.00 sec)
		
		连接查询也算是SIMPLE类型:
		
			root@mysqldb 14:14:  [audit_db]> EXPLAIN SELECT * FROM t1 INNER JOIN t2;
			+----+-------------+-------+------------+------+---------------+------+---------+------+-------+----------+---------------------------------------+
			| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows  | filtered | Extra                                 |
			+----+-------------+-------+------------+------+---------------+------+---------+------+-------+----------+---------------------------------------+
			|  1 | SIMPLE      | t2    | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 10210 |   100.00 | NULL                                  |
			|  1 | SIMPLE      | t1    | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 10212 |   100.00 | Using join buffer (Block Nested Loop) |
			+----+-------------+-------+------------+------+---------------+------+---------+------+-------+----------+---------------------------------------+
			2 rows in set, 1 warning (0.00 sec)
			
	PRIMARY
		
		对于包含UNION、UNION ALL或者子查询的大查询来说，它是由几个小查询组成的，其中最左边的那个查询的select_type值就是PRIMARY，比方说：
		
		root@mysqldb 14:45:  [audit_db]> EXPLAIN SELECT * FROM t1  UNION SELECT * FROM t2;
		+----+--------------+------------+------------+------+---------------+------+---------+------+-------+----------+-----------------+
		| id | select_type  | table      | partitions | type | possible_keys | key  | key_len | ref  | rows  | filtered | Extra           |
		+----+--------------+------------+------------+------+---------------+------+---------+------+-------+----------+-----------------+
		|  1 | PRIMARY      | t1         | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 10212 |   100.00 | NULL            |
		|  2 | UNION        | t2         | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 10210 |   100.00 | NULL            |
		| NULL | UNION RESULT | <union1,2> | NULL       | ALL  | NULL          | NULL | NULL    | NULL |  NULL |     NULL | Using temporary |
		+----+--------------+------------+------------+------+---------------+------+---------+------+-------+----------+-----------------+
		3 rows in set, 1 warning (0.08 sec)
		
		
		root@mysqldb 15:19:  [audit_db]> EXPLAIN SELECT * FROM t1  UNION ALL SELECT * FROM t2;
		+----+-------------+-------+------------+------+---------------+------+---------+------+-------+----------+-------+
		| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows  | filtered | Extra |
		+----+-------------+-------+------------+------+---------------+------+---------+------+-------+----------+-------+
		|  1 | PRIMARY     | t1    | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 10212 |   100.00 | NULL  |
		|  2 | UNION       | t2    | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 10210 |   100.00 | NULL  |
		+----+-------------+-------+------------+------+---------------+------+---------+------+-------+----------+-------+
		2 rows in set, 1 warning (0.00 sec)

		最左边的小查询 SELECT * FROM t1 对应的是执行计划中的第一条记录，它的select_type值就是PRIMARY。
		
		
	5.3 UNION
	
		对于包含UNION或者UNION ALL的大查询来说，它是由几个小查询组成的，其中除了最左边的那个小查询以外，其余的小查询的select_type值就是UNION，可以对比上一个例子的效果，这就不多举例子了。
	
	5.4 UNION RESULT
	
		MySQL选择使用临时表来完成UNION查询的去重工作，针对该临时表的查询的select_type就是 UNION RESULT，例子上边有，就不赘述了。
			
	5.5 SUBQUERY 
		
		SUBQUERY：子查询
		
		如果包含子查询的查询语句不能够转为对应的 semi join 的形式，并且该子查询是不相关子查询，并且查询优化器决定采用将该子查询物化的方案来执行该子查询时
		该子查询的第一个SELECT关键字代表的那个查询的 select_type 就是 SUBQUERY ，比如下边这个查询：	
			
		root@mysqldb 15:30:  [audit_db]> EXPLAIN SELECT * FROM t1 WHERE key1 IN (SELECT key1 FROM t2) OR key3 = '3';
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+-------+----------+-------------+
		| id | select_type | table | partitions | type  | possible_keys | key      | key_len | ref  | rows  | filtered | Extra       |
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+-------+----------+-------------+
		|  1 | PRIMARY     | t1    | NULL       | ALL   | idx_key3      | NULL     | NULL    | NULL | 10212 |   100.00 | Using where |
		|  2 | SUBQUERY    | t2    | NULL       | index | idx_key1      | idx_key1 | 403     | NULL | 10210 |   100.00 | Using index |
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+-------+----------+-------------+
		2 rows in set, 1 warning (0.00 sec)
		
		外层查询的select_type就是PRIMARY，子查询的select_type就是SUBQUERY。
		由于select_type为SUBQUERY的子查询会被物化，所以只需要执行一遍。	
		
		先将子查询物化，然后再判断key1是否在物化表的结果集中可以加快查询执行的速度。
		注意事项：请注意这里将子查询物化之后不能转为和外层查询的表的连接，只能是先扫描s1表，然后对t1表的某条记录来说，判断该记录的key1值在不在物化表中。
		
		root@mysqldb 15:39:  [audit_db]> show warnings;
		+-------+------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| Level | Code | Message                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
		+-------+------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| Note  | 1003 | /* select#1 */ select `audit_db`.`t1`.`id` AS `id`,`audit_db`.`t1`.`key1` AS `key1`,`audit_db`.`t1`.`key2` AS `key2`,`audit_db`.`t1`.`key3` AS `key3`,`audit_db`.`t1`.`common_field` AS `common_field` from `audit_db`.`t1` where (<in_optimizer>(`audit_db`.`t1`.`key1`,`audit_db`.`t1`.`key1` in ( <materialize> (/* select#2 */ select `audit_db`.`t2`.`key1` from `audit_db`.`t2` where 1 ), <primary_index_lookup>(`audit_db`.`t1`.`key1` in <temporary table> on <auto_key> where ((`audit_db`.`t1`.`key1` = `materialized-subquery`.`key1`))))) or (`audit_db`.`t1`.`key3` = '3')) |
		+-------+------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		1 row in set (0.00 sec)
				
			SELECT
				`audit_db`.`t1`.`id` AS `id`,
				`audit_db`.`t1`.`key1` AS `key1`,
				`audit_db`.`t1`.`key2` AS `key2`,
				`audit_db`.`t1`.`key3` AS `key3`,
				`audit_db`.`t1`.`common_field` AS `common_field`
			FROM
				`audit_db`.`t1`
			WHERE
				(
					< in_optimizer > (
						`audit_db`.`t1`.`key1`,
						`audit_db`.`t1`.`key1` IN (
							< materialize > (
								/* select#2 */
								SELECT
									`audit_db`.`t2`.`key1`
								FROM
									`audit_db`.`t2`
								WHERE
									1
							),
							< primary_index_lookup > (
								`audit_db`.`t1`.`key1` IN < TEMPORARY TABLE > ON < auto_key >
								WHERE
									(
										(
											`audit_db`.`t1`.`key1` = `materialized-subquery`.`key1`
										)
									)
							)
						)
					)
					OR (`audit_db`.`t1`.`key3` = '3')
				) 		
				
		

	5.6 DEPENDENT SUBQUERY
		
		DEPENDENT SUBQUERY：依赖子查询

		如果包含子查询的查询语句不能够转为对应的 semi join 的形式，并且该子查询是相关子查询，则该子查询的第一个SELECT关键字代表的那个查询的 select_type 就是 DEPENDENT SUBQUERY，比如下边这个查询：
		
		root@mysqldb 15:45:  [audit_db]> EXPLAIN SELECT * FROM t1 WHERE key1 IN (SELECT key1 FROM t2 WHERE t1.key2 = t2.key2) OR key3 = '3';
		+----+--------------------+-------+------------+------+-------------------+----------+---------+------------------+-------+----------+-------------+
		| id | select_type        | table | partitions | type | possible_keys     | key      | key_len | ref              | rows  | filtered | Extra       |
		+----+--------------------+-------+------------+------+-------------------+----------+---------+------------------+-------+----------+-------------+
		|  1 | PRIMARY            | t1    | NULL       | ALL  | idx_key3          | NULL     | NULL    | NULL             | 10212 |   100.00 | Using where |
		|  2 | DEPENDENT SUBQUERY | t2    | NULL       | ref  | idx_key2,idx_key1 | idx_key2 | 5       | audit_db.t1.key2 |     1 |    10.00 | Using where |
		+----+--------------------+-------+------------+------+-------------------+----------+---------+------------------+-------+----------+-------------+
		2 rows in set, 2 warnings (0.01 sec)
		
		select_type 为 DEPENDENT SUBQUERY 的查询可能会被执行多次。
		执行流程是怎么样的？
		
				
		root@mysqldb 15:45:  [audit_db]> show warnings;
		+-------+------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| Level | Code | Message                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
		+-------+------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| Note  | 1276 | Field or reference 'audit_db.t1.key2' of SELECT #2 was resolved in SELECT #1                                                                                                                                                                                                                                                                                                                                                                                                                 |
		| Note  | 1003 | /* select#1 */ select `audit_db`.`t1`.`id` AS `id`,`audit_db`.`t1`.`key1` AS `key1`,`audit_db`.`t1`.`key2` AS `key2`,`audit_db`.`t1`.`key3` AS `key3`,`audit_db`.`t1`.`common_field` AS `common_field` from `audit_db`.`t1` where (<in_optimizer>(`audit_db`.`t1`.`key1`,<exists>(/* select#2 */ select 1 from `audit_db`.`t2` where ((`audit_db`.`t1`.`key2` = `audit_db`.`t2`.`key2`) and (<cache>(`audit_db`.`t1`.`key1`) = `audit_db`.`t2`.`key1`)))) or (`audit_db`.`t1`.`key3` = '3')) |
		+-------+------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		2 rows in set (0.01 sec)
						
			SELECT
				`audit_db`.`t1`.`id` AS `id`,
				`audit_db`.`t1`.`key1` AS `key1`,
				`audit_db`.`t1`.`key2` AS `key2`,
				`audit_db`.`t1`.`key3` AS `key3`,
				`audit_db`.`t1`.`common_field` AS `common_field`
			FROM
				`audit_db`.`t1`
			WHERE
				(
					< in_optimizer > (
						`audit_db`.`t1`.`key1` ,< EXISTS > (
							/* select#2 */
							SELECT
								1
							FROM
								`audit_db`.`t2`
							WHERE
								(
									(
										`audit_db`.`t1`.`key2` = `audit_db`.`t2`.`key2`
									)
									AND (
										< CACHE > (`audit_db`.`t1`.`key1`) = `audit_db`.`t2`.`key1`
									)
								)
						)
					)
					OR (`audit_db`.`t1`.`key3` = '3')
				)


		
		
		
	5.7 DEPENDENT UNION

		在包含UNION或者UNION ALL的大查询中，如果各个小查询都依赖于外层查询的话，那除了最左边的那个小查询之外，其余的小查询的select_type的值就是DEPENDENT UNION。比方说下边这个查询：	
		
		root@mysqldb 15:45:  [audit_db]> EXPLAIN SELECT * FROM t1 WHERE key1 IN (SELECT key1 FROM t2 WHERE key1 = '3' UNION SELECT key1 FROM t1 WHERE key1 = '3');
		+----+--------------------+------------+------------+------+---------------+----------+---------+-------+-------+----------+--------------------------+
		| id | select_type        | table      | partitions | type | possible_keys | key      | key_len | ref   | rows  | filtered | Extra                    |
		+----+--------------------+------------+------------+------+---------------+----------+---------+-------+-------+----------+--------------------------+
		|  1 | PRIMARY            | t1         | NULL       | ALL  | NULL          | NULL     | NULL    | NULL  | 10212 |   100.00 | Using where              |
		|  2 | DEPENDENT SUBQUERY | t2         | NULL       | ref  | idx_key1      | idx_key1 | 403     | const |   107 |   100.00 | Using where; Using index |
		|  3 | DEPENDENT UNION    | t1         | NULL       | ref  | idx_key1      | idx_key1 | 403     | const |    88 |   100.00 | Using where; Using index |
		| NULL | UNION RESULT       | <union2,3> | NULL       | ALL  | NULL          | NULL     | NULL    | NULL  |  NULL |     NULL | Using temporary          |
		+----+--------------------+------------+------------+------+---------------+----------+---------+-------+-------+----------+--------------------------+
		4 rows in set, 1 warning (0.00 sec)
				
		这个查询比较复杂啊，大查询里包含了一个子查询，子查询里又是由UNION连起来的两个小查询。
		从执行计划中可以看出来，SELECT key1 FROM t2 WHERE key1 = '3' 这个小查询由于是子查询中第一个查询，所以它的 select_type 是 DEPENDENT SUBQUERY
		而 SELECT key1 FROM t1 WHERE key1 = '3' 这个查询的 select_type 就是 DEPENDENT UNION 。
	
	5.8 DERIVED
		
		DERIVED：派生表
		
		对于采用物化的方式执行的包含派生表的查询，该派生表对应的子查询的select_type就是DERIVED，比方说下边这个查询：
		
		root@mysqldb 15:58:  [audit_db]> EXPLAIN SELECT * FROM (SELECT key1, count(*) as c FROM t1 GROUP BY key1) AS derived_s1 where c > 1;
		+----+-------------+------------+------------+-------+---------------+----------+---------+------+-------+----------+-------------+
		| id | select_type | table      | partitions | type  | possible_keys | key      | key_len | ref  | rows  | filtered | Extra       |
		+----+-------------+------------+------------+-------+---------------+----------+---------+------+-------+----------+-------------+
		|  1 | PRIMARY     | <derived2> | NULL       | ALL   | NULL          | NULL     | NULL    | NULL | 10212 |    33.33 | Using where |
		|  2 | DERIVED     | t1         | NULL       | index | idx_key1      | idx_key1 | 403     | NULL | 10212 |   100.00 | Using index |
		+----+-------------+------------+------------+-------+---------------+----------+---------+------+-------+----------+-------------+
		2 rows in set, 1 warning (0.00 sec)

		从执行计划中可以看出，id为2的记录就代表子查询的执行方式，它的 select_type 是 DERIVED ，说明该子查询是以物化的方式执行的。
		id为1的记录代表外层查询，大家注意看它的 table 列显示的是 <derived2> ，表示该查询是针对将派生表物化之后的表进行查询的。
		
		root@mysqldb 17:11:  [audit_db]> show warnings;
		+-------+------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| Level | Code | Message                                                                                                                                                                                                                                                  |
		+-------+------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| Note  | 1003 | /* select#1 */ select `derived_s1`.`key1` AS `key1`,`derived_s1`.`c` AS `c` from (/* select#2 */ select `audit_db`.`t1`.`key1` AS `key1`,count(0) AS `c` from `audit_db`.`t1` group by `audit_db`.`t1`.`key1`) `derived_s1` where (`derived_s1`.`c` > 1) |
		+-------+------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		1 row in set (0.00 sec)

			SELECT
				`derived_s1`.`key1` AS `key1`,
				`derived_s1`.`c` AS `c`
			FROM
				(
					/* select#2 */
					SELECT
						`audit_db`.`t1`.`key1` AS `key1`,
						count(0) AS `c`
					FROM
						`audit_db`.`t1`
					GROUP BY
						`audit_db`.`t1`.`key1`
				) `derived_s1`
			WHERE
				(`derived_s1`.`c` > 1) 
				
				
	5.9 MATERIALIZED
		
		MATERIALIZED：物化表
		
		当查询优化器在执行包含子查询的语句时，选择将子查询物化之后与外层查询进行连接查询时，该子查询对应的select_type属性就是MATERIALIZED，比如下边这个查询：
		
		root@mysqldb 16:14:  [audit_db]> EXPLAIN SELECT * FROM t1 WHERE key1 IN (SELECT key1 FROM t2);
		+----+--------------+-------------+------------+--------+---------------+------------+---------+------------------+-------+----------+-------------+
		| id | select_type  | table       | partitions | type   | possible_keys | key        | key_len | ref              | rows  | filtered | Extra       |
		+----+--------------+-------------+------------+--------+---------------+------------+---------+------------------+-------+----------+-------------+
		|  1 | SIMPLE       | t1          | NULL       | ALL    | idx_key1      | NULL       | NULL    | NULL             | 10212 |   100.00 | Using where |
		|  1 | SIMPLE       | <subquery2> | NULL       | eq_ref | <auto_key>    | <auto_key> | 403     | audit_db.t1.key1 |     1 |   100.00 | NULL        |
		|  2 | MATERIALIZED | t2          | NULL       | index  | idx_key1      | idx_key1   | 403     | NULL             | 10210 |   100.00 | Using index |
		+----+--------------+-------------+------------+--------+---------------+------------+---------+------------------+-------+----------+-------------+
		3 rows in set, 1 warning (0.00 sec)

		执行计划的第三条记录的id值为2，说明该条记录对应的是一个单表查询，从它的 select_type 值为 MATERIALIZED 可以看出，查询优化器是要把子查询先转换成物化表。
		然后看执行计划的前两条记录的id值都为1，说明这两条记录对应的表进行连接查询
		需要注意的是第二条记录的table列的值是 <subquery2> ，说明该表其实就是id为2对应的子查询执行之后产生的物化表，然后将 t1 和该物化表进行连接查询。
		
		
		root@mysqldb 16:26:  [audit_db]> show warnings;
		+-------+------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| Level | Code | Message                                                                                                                                                                                                                                                                                                       |
		+-------+------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| Note  | 1003 | /* select#1 */ select `audit_db`.`t1`.`id` AS `id`,`audit_db`.`t1`.`key1` AS `key1`,`audit_db`.`t1`.`key2` AS `key2`,`audit_db`.`t1`.`key3` AS `key3`,`audit_db`.`t1`.`common_field` AS `common_field` from `audit_db`.`t1` semi join (`audit_db`.`t2`) where (`<subquery2>`.`key1` = `audit_db`.`t1`.`key1`) |
		+-------+------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		1 row in set (0.00 sec)
				
		
		SELECT
			`audit_db`.`t1`.`id` AS `id`,
			`audit_db`.`t1`.`key1` AS `key1`,
			`audit_db`.`t1`.`key2` AS `key2`,
			`audit_db`.`t1`.`key3` AS `key3`,
			`audit_db`.`t1`.`common_field` AS `common_field`
		FROM
			`audit_db`.`t1` semi
		JOIN (`audit_db`.`t2`)
		WHERE
			(
				`<subquery2>`.`key1` = `audit_db`.`t1`.`key1`
			) |
		
		
		
		
		

		
		
		
		