

子查询是不相关子查询
	SELECT * FROM t1 WHERE key1 IN (SELECT key1 FROM t2)
	
子查询是相关子查询
	SELECT * FROM t1 WHERE key1 IN (SELECT key1 FROM t2 WHERE t1.key2 = t2.key2) OR key3 = '3';

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