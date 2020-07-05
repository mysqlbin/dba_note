


在我们使用EXPLAIN语句查看了某个查询的执行计划后，紧接着还可以使用 SHOW WARNINGS 语句查看与这个查询的执行计划有关的一些扩展信息

mysql> EXPLAIN SELECT s1.key1, s2.key1 FROM s1 LEFT JOIN s2 ON s1.key1 = s2.key1 WHERE s2.common_field IS NOT NULL;
+----+-------------+-------+------------+------+---------------+----------+---------+-------------------+------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key      | key_len | ref               | rows | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+----------+---------+-------------------+------+----------+-------------+
|  1 | SIMPLE      | s2    | NULL       | ALL  | idx_key1      | NULL     | NULL    | NULL              | 9954 |    90.00 | Using where |
|  1 | SIMPLE      | s1    | NULL       | ref  | idx_key1      | idx_key1 | 303     | xiaohaizi.s2.key1 |    1 |   100.00 | Using index |
+----+-------------+-------+------------+------+---------------+----------+---------+-------------------+------+----------+-------------+
2 rows in set, 1 warning (0.00 sec)

mysql> SHOW WARNINGS\G
	*************************** 1. row ***************************
	  Level: Note
	   Code: 1003
	Message: /* select#1 */ select `xiaohaizi`.`s1`.`key1` AS `key1`,`xiaohaizi`.`s2`.`key1` AS `key1` from `xiaohaizi`.`s1` join `xiaohaizi`.`s2` where ((`xiaohaizi`.`s1`.`key1` = `xiaohaizi`.`s2`.`key1`) and (`xiaohaizi`.`s2`.`common_field` is not null))
	1 row in set (0.00 sec)

	SELECT
		`xiaohaizi`.`s1`.`key1` AS `key1`,
		`xiaohaizi`.`s2`.`key1` AS `key1`
	FROM
		`xiaohaizi`.`s1`
	JOIN `xiaohaizi`.`s2`
	WHERE
		(
			(
				`xiaohaizi`.`s1`.`key1` = `xiaohaizi`.`s2`.`key1`
			)
			AND (
				`xiaohaizi`.`s2`.`common_field` IS NOT NULL
			)
		)
	

大家可以看到SHOW WARNINGS展示出来的信息有三个字段，分别是Level、Code、Message。
我们最常见的就是Code为1003的信息，当Code值为1003时，Message字段展示的信息类似于查询优化器将我们的查询语句重写后的语句。
比如我们上边的查询本来是一个左（外）连接查询，但是有一个 s2.common_field IS NOT NULL 的条件，着就会导致查询优化器把左（外）连接查询优化为内连接查询，从SHOW WARNINGS的Message字段也可以看出来，原本的LEFT JOIN已经变成了JOIN。


但是大家一定要注意，我们说Message字段展示的信息类似于查询优化器将我们的查询语句重写后的语句，并不是等价于，也就是说Message字段展示的信息并不是标准的查询语句，在很多情况下并不能直接拿到黑框框中运行，它只能作为帮助我们理解查MySQL将如何执行查询语句的一个参考依据而已。

