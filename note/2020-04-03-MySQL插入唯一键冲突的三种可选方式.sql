
1. Ignore关键词
2. Replace Into方式
3. insert into … on duplicate key update	
4. 相关参考



1. Ignore关键词
	某些场景下，我们需要批量插入的数据，某些已经在DB中了，因此我希望在出现冲突时，直接跳过，把能插入的都插入就好，这种情况下，使用ignore关键词就比较合适了

	

	CREATE TABLE `t10` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `a` int(11) DEFAULT NULL,
	  `b` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `a` (`a`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

	insert Ignore into t10(`a`,`b`) values(1,1);
	insert Ignore into t10(`a`,`b`) values(2,1);
	insert Ignore into t10(`a`,`b`) values(1,1);
	insert Ignore into t10(`a`,`b`) values(1,1);
	
	select * from t10;
	
	root@mysqldb 11:06:  [test_db]> insert Ignore into t10(`a`,`b`) values(1,1);
	Query OK, 1 row affected (0.01 sec)

	root@mysqldb 11:06:  [test_db]> insert Ignore into t10(`a`,`b`) values(2,1);
	Query OK, 1 row affected (0.02 sec)

	root@mysqldb 11:06:  [test_db]> insert Ignore into t10(`a`,`b`) values(1,1);
	Query OK, 0 rows affected, 1 warning (0.03 sec)

	root@mysqldb 11:06:  [test_db]> insert Ignore into t10(`a`,`b`) values(1,1);
	Query OK, 0 rows affected, 1 warning (0.00 sec)

	root@mysqldb 11:06:  [test_db]> select * from t10;
	+----+------+------+
	| id | a    | b    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    1 |
	+----+------+------+
	2 rows in set (0.00 sec)

	
2. Replace Into方式
	如果在批量插入中，存在冲突时，我希望用我的新数据替换旧的数据，这个时候就可以使用replace into了
	
	drop table t10;
	CREATE TABLE `t10` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `a` int(11) DEFAULT NULL,
	  `b` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `a` (`a`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

	insert into t10(`a`,`b`) values(1,1);
	insert into t10(`a`,`b`) values(2,1);

	root@mysqldb 11:09:  [test_db]> select * from t10;
	+----+------+------+
	| id | a    | b    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    1 |
	+----+------+------+
	2 rows in set (0.00 sec)

	root@mysqldb 11:13:  [test_db]> show create table t10\G;
	*************************** 1. row ***************************
		   Table: t10
	Create Table: CREATE TABLE `t10` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `a` int(11) DEFAULT NULL,
	  `b` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `a` (`a`)
	) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)


	root@mysqldb 11:13:  [test_db]> replace into t10(`a`,`b`) values(2,2);
	Query OK, 2 rows affected (0.01 sec)

	root@mysqldb 11:13:  [test_db]> replace into t10(`a`,`b`) values(3,3);
	Query OK, 1 row affected (0.01 sec)

	root@mysqldb 11:13:  [test_db]> select * from t10;
	+----+------+------+
	| id | a    | b    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  3 |    2 |    2 |   -- 原来id=2，现在id=3
	|  4 |    3 |    3 |
	+----+------+------+
	3 rows in set (0.00 sec)
	
	
	可以看到, 当某条记录冲突之后并修改，则影响行数为2, 其实际过程是：
		删除冲突数据
		插入新的数据
	
3. insert into … on duplicate key update	
   insert into … on duplicate key update 这个语义的逻辑：
        插入一行数据，如果碰到唯一键约束，就执行后面的更新语句。
        如果有多个列违反了唯一性约束，就会按照索引的顺序，修改跟第一个索引冲突的行。 

	CREATE TABLE `t20` (
		`id` int(11) NOT NULL AUTO_INCREMENT,
		`c` int(11) DEFAULT NULL,
		`d` int(11) DEFAULT NULL,
		PRIMARY KEY (`id`),
		UNIQUE KEY `c` (`c`)
	) ENGINE=InnoDB;
	
	insert into t20 values(1,1,1);
	insert into t20 values(2,2,2);
	
	root@mysqldb 11:13:  [test_db]> select * from t20;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	+----+------+------+
	2 rows in set (0.00 sec)
	
	root@mysqldb 11:18:  [test_db]> insert into t20 values(2, 1, 100) on duplicate key update d=100;
	Query OK, 2 rows affected (0.01 sec)

	root@mysqldb 11:18:  [test_db]> select * from t20;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |  100 |
	+----+------+------+
	2 rows in set (0.00 sec)
	
	
	表 t 里面已经有了 (1,1,1) 和 (2,2,2) 这两行；
        执行语句： insert into t values(2, 1, 100) on duplicate key update d=100;
        主键 id 是先判断的，MySQL 认为这个语句跟 id=2 这一行冲突，所以修改的是 id=2 的行。
        执行这条语句的 affected rows 返回的是 2，很容易造成误解
		实际上，真正更新的只有一行，只是在代码实现上，insert 和 update 都认为自己成功了，update 计数加了 1， insert 计数也加了.
		
	在原记录的基础上执行更新指定的value, 比如上面的插入中，当冲突时，我们只更新 d 字段
	
4. 相关参考
	https://www.cnblogs.com/yihuihui/p/9291235.html   180710-MySql插入唯一键冲突的三种可选方式
	笔记 <40 | insert语句的锁为什么这么多？>

	