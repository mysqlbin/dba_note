
1. 两表的 join 
	1.1 表的DLL和数据初始化
	1.2 join
	1.3 inner join
	1.4 left join
	1.5 right join
	
2. 三表join
	2.1 表的DLL和数据初始化
	2.2 left join inner join 
	2.3 inner join inner join 
	2.4 left join left join 
	2.5 join join 
	 
3. 小结

1. 两表的 join 
	
	1.1 表的DLL和数据初始化

		CREATE TABLE  t_a(
		aID int(1) AUTO_INCREMENT PRIMARY KEY,
		aNum varchar(20)
		);
		CREATE TABLE t_b(
		bID int(1) NOT NULL AUTO_INCREMENT PRIMARY KEY,
		bName varchar(20) 
		);

		INSERT INTO t_a
		VALUES ( 1, 'a20050111' ) , ( 2, 'a20050112' ) , ( 3, 'a20050113' ) , ( 4, 'a20050114' ) , ( 5, 'a20050115' ) ;

		INSERT INTO t_b
		VALUES ( 1, ' 2006032401' ) , ( 2, '2006032402' ) , ( 3, '2006032403' ) , ( 4, '2006032404' ) , ( 8, '2006032408' ) ;


	1.2 join

		root@mysqldb 14:13:  [test_db]> select * from t_a a join t_b b on a.aID=b.bID;
		+-----+-----------+-----+-------------+
		| aID | aNum      | bID | bName       |
		+-----+-----------+-----+-------------+
		|   1 | a20050111 |   1 |  2006032401 |
		|   2 | a20050112 |   2 | 2006032402  |
		|   3 | a20050113 |   3 | 2006032403  |
		|   4 | a20050114 |   4 | 2006032404  |
		+-----+-----------+-----+-------------+
		4 rows in set (0.00 sec)

	1.3 inner join

		root@mysqldb 14:14:  [test_db]> select * from t_a a inner join t_b b on a.aID=b.bID;
		+-----+-----------+-----+-------------+
		| aID | aNum      | bID | bName       |
		+-----+-----------+-----+-------------+
		|   1 | a20050111 |   1 |  2006032401 |
		|   2 | a20050112 |   2 | 2006032402  |
		|   3 | a20050113 |   3 | 2006032403  |
		|   4 | a20050114 |   4 | 2006032404  |
		+-----+-----------+-----+-------------+
		4 rows in set (0.00 sec)

	1.4 left join

		root@mysqldb 14:14:  [test_db]> select * from t_a a left join t_b b on a.aID=b.bID;
		+-----+-----------+------+-------------+
		| aID | aNum      | bID  | bName       |
		+-----+-----------+------+-------------+
		|   1 | a20050111 |    1 |  2006032401 |
		|   2 | a20050112 |    2 | 2006032402  |
		|   3 | a20050113 |    3 | 2006032403  |
		|   4 | a20050114 |    4 | 2006032404  |
		|   5 | a20050115 | NULL | NULL        |
		+-----+-----------+------+-------------+
		5 rows in set (0.00 sec)

	1.5 right join
		root@mysqldb 14:14:  [test_db]> select * from t_a a right join t_b b on a.aID=b.bID;
		+------+-----------+-----+-------------+
		| aID  | aNum      | bID | bName       |
		+------+-----------+-----+-------------+
		|    1 | a20050111 |   1 |  2006032401 |
		|    2 | a20050112 |   2 | 2006032402  |
		|    3 | a20050113 |   3 | 2006032403  |
		|    4 | a20050114 |   4 | 2006032404  |
		| NULL | NULL      |   8 | 2006032408  |
		+------+-----------+-----+-------------+
		5 rows in set (0.00 sec)

2. 三表join

	2.1 表的DLL和数据初始化
	2.2 left join inner join 
	2.3 inner join inner join 
	2.4 left join left join 
	2.5 join join 
	
	2.1 表的DLL和数据初始化
		CREATE TABLE  t_a(
		aID int(1) AUTO_INCREMENT PRIMARY KEY,
		aNum varchar(20)
		);
		CREATE TABLE t_b(
		bID int(1) NOT NULL AUTO_INCREMENT PRIMARY KEY,
		bName varchar(20) 
		);
		
		CREATE TABLE t_c(
		cID int(1) NOT NULL AUTO_INCREMENT PRIMARY KEY,
		bName varchar(20) 
		);

		INSERT INTO t_a
		VALUES ( 1, 'a20050111' ) , ( 2, 'a20050112' ) , ( 3, 'a20050113' ) , ( 4, 'a20050114' ) , ( 5, 'a20050115' ) ;

		INSERT INTO t_b
		VALUES ( 1, ' 2006032401' ) , ( 2, '2006032402' ) , ( 3, '2006032403' ) , ( 7, '2006032404' ) , ( 8, '2006032408' ) ;

		INSERT INTO t_c
		VALUES ( 1, ' 2006032401' ) , ( 2, '2006032402' ) , ( 3, '2006032403' ) , ( 4, '2006032404' ) , ( 10, '2006032408' ) ;


	2.2 left join inner join 
	
		root@mysqldb 11:36:  [test_db]> desc select * from t_a a left join t_b b on a.aID=b.bID inner join t_c c on a.aID=c.cID;
		+----+-------------+-------+------------+--------+---------------+---------+---------+---------------+------+----------+-------+
		| id | select_type | table | partitions | type   | possible_keys | key     | key_len | ref           | rows | filtered | Extra |
		+----+-------------+-------+------------+--------+---------------+---------+---------+---------------+------+----------+-------+
		|  1 | SIMPLE      | a     | NULL       | ALL    | PRIMARY       | NULL    | NULL    | NULL          |    5 |   100.00 | NULL  |
		|  1 | SIMPLE      | c     | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | test_db.a.aID |    1 |   100.00 | NULL  |
		|  1 | SIMPLE      | b     | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | test_db.a.aID |    1 |   100.00 | NULL  |
		+----+-------------+-------+------------+--------+---------------+---------+---------+---------------+------+----------+-------+
		3 rows in set, 1 warning (0.00 sec)
		
		root@mysqldb 11:36:  [test_db]> select * from t_a a left join t_b b on a.aID=b.bID inner join t_c c on a.aID=c.cID;
		+-----+-----------+------+-------------+-----+-------------+
		| aID | aNum      | bID  | bName       | cID | bName       |
		+-----+-----------+------+-------------+-----+-------------+
		|   1 | a20050111 |    1 |  2006032401 |   1 |  2006032401 |
		|   2 | a20050112 |    2 | 2006032402  |   2 | 2006032402  |
		|   3 | a20050113 |    3 | 2006032403  |   3 | 2006032403  |
		|   4 | a20050114 | NULL | NULL        |   4 | 2006032404  |
		+-----+-----------+------+-------------+-----+-------------+
		4 rows in set (0.00 sec)

	
	2.3 inner join inner join 
		root@mysqldb 11:36:  [test_db]> desc select * from t_a a inner join t_b b on a.aID=b.bID inner join t_c c on a.aID=c.cID;
		+----+-------------+-------+------------+--------+---------------+---------+---------+---------------+------+----------+-------+
		| id | select_type | table | partitions | type   | possible_keys | key     | key_len | ref           | rows | filtered | Extra |
		+----+-------------+-------+------------+--------+---------------+---------+---------+---------------+------+----------+-------+
		|  1 | SIMPLE      | a     | NULL       | ALL    | PRIMARY       | NULL    | NULL    | NULL          |    5 |   100.00 | NULL  |
		|  1 | SIMPLE      | b     | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | test_db.a.aID |    1 |   100.00 | NULL  |
		|  1 | SIMPLE      | c     | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | test_db.a.aID |    1 |   100.00 | NULL  |
		+----+-------------+-------+------------+--------+---------------+---------+---------+---------------+------+----------+-------+
		3 rows in set, 1 warning (0.00 sec)

		root@mysqldb 11:37:  [test_db]> select * from t_a a inner join t_b b on a.aID=b.bID inner join t_c c on a.aID=c.cID;
		+-----+-----------+-----+-------------+-----+-------------+
		| aID | aNum      | bID | bName       | cID | bName       |
		+-----+-----------+-----+-------------+-----+-------------+
		|   1 | a20050111 |   1 |  2006032401 |   1 |  2006032401 |
		|   2 | a20050112 |   2 | 2006032402  |   2 | 2006032402  |
		|   3 | a20050113 |   3 | 2006032403  |   3 | 2006032403  |
		+-----+-----------+-----+-------------+-----+-------------+
		3 rows in set (0.01 sec)

	
	2.4 left join left join 
	
		root@mysqldb 11:37:  [test_db]> select * from t_a a left join t_b b on a.aID=b.bID left join t_c c on a.aID=c.cID;
		+-----+-----------+------+-------------+------+-------------+
		| aID | aNum      | bID  | bName       | cID  | bName       |
		+-----+-----------+------+-------------+------+-------------+
		|   1 | a20050111 |    1 |  2006032401 |    1 |  2006032401 |
		|   2 | a20050112 |    2 | 2006032402  |    2 | 2006032402  |
		|   3 | a20050113 |    3 | 2006032403  |    3 | 2006032403  |
		|   4 | a20050114 | NULL | NULL        |    4 | 2006032404  |
		|   5 | a20050115 | NULL | NULL        | NULL | NULL        |
		+-----+-----------+------+-------------+------+-------------+
		5 rows in set (0.00 sec)

		root@mysqldb 11:38:  [test_db]> desc select * from t_a a left join t_b b on a.aID=b.bID left join t_c c on a.aID=c.cID;
		+----+-------------+-------+------------+--------+---------------+---------+---------+---------------+------+----------+-------+
		| id | select_type | table | partitions | type   | possible_keys | key     | key_len | ref           | rows | filtered | Extra |
		+----+-------------+-------+------------+--------+---------------+---------+---------+---------------+------+----------+-------+
		|  1 | SIMPLE      | a     | NULL       | ALL    | NULL          | NULL    | NULL    | NULL          |    5 |   100.00 | NULL  |
		|  1 | SIMPLE      | b     | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | test_db.a.aID |    1 |   100.00 | NULL  |
		|  1 | SIMPLE      | c     | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | test_db.a.aID |    1 |   100.00 | NULL  |
		+----+-------------+-------+------------+--------+---------------+---------+---------+---------------+------+----------+-------+
		3 rows in set, 1 warning (0.00 sec)
		
	2.5 join join 

		root@mysqldb 11:38:  [test_db]> desc select * from t_a a join t_b b on a.aID=b.bID  join t_c c on a.aID=c.cID;
		+----+-------------+-------+------------+--------+---------------+---------+---------+---------------+------+----------+-------+
		| id | select_type | table | partitions | type   | possible_keys | key     | key_len | ref           | rows | filtered | Extra |
		+----+-------------+-------+------------+--------+---------------+---------+---------+---------------+------+----------+-------+
		|  1 | SIMPLE      | a     | NULL       | ALL    | PRIMARY       | NULL    | NULL    | NULL          |    5 |   100.00 | NULL  |
		|  1 | SIMPLE      | b     | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | test_db.a.aID |    1 |   100.00 | NULL  |
		|  1 | SIMPLE      | c     | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | test_db.a.aID |    1 |   100.00 | NULL  |
		+----+-------------+-------+------------+--------+---------------+---------+---------+---------------+------+----------+-------+
		3 rows in set, 1 warning (0.00 sec)

		root@mysqldb 11:38:  [test_db]> select * from t_a a join t_b b on a.aID=b.bID  join t_c c on a.aID=c.cID;
		+-----+-----------+-----+-------------+-----+-------------+
		| aID | aNum      | bID | bName       | cID | bName       |
		+-----+-----------+-----+-------------+-----+-------------+
		|   1 | a20050111 |   1 |  2006032401 |   1 |  2006032401 |
		|   2 | a20050112 |   2 | 2006032402  |   2 | 2006032402  |
		|   3 | a20050113 |   3 | 2006032403  |   3 | 2006032403  |
		+-----+-----------+-----+-------------+-----+-------------+
		3 rows in set (0.01 sec)

	
3. 小结

	可以看到, join 跟 inner join 得到的结果集是一样的，也就是说在MySQL中，下边这几种内连接的写法都是等价的：

		SELECT * FROM t1 JOIN t2;

		SELECT * FROM t1 INNER JOIN t2;

		SELECT * FROM t1 CROSS JOIN t2;
		
	事情要一样一样地做好来, 学习技术也是.
	
	

