
1. SQL_MODE简介
2. SQL_MODE的完整列表即每个参数的含义和使用
	2.1 ALLOW_INVALID_DATE
	2.2 ANSI_QUOTES
	2.3 ERROR_FOR_DIVISION_BY_ZERO
	2.4 HIGH_NOT_PRECEDENCE
	2.5 IGNORE_SPACE
	2.6 NO_AUTO_VALUE_ON_ZERO
	2.7 NO_BACKSLASH_ESCAPES
	2.8 NO_DIR_IN_CREATE
	2.9 NO_ENGINE_SUBSTITUTION
	2.10 NO_UNSIGNED_SUBTRACTION
	2.11 NO_ZERO_DATE
	2.12 NO_ZERO_IN_DATE
	2.13 ONLY_FULL_GROUP_BY
	2.14 PAD_CHAR_TO_FULL_LENGTH
	2.15 PIPES_AS_CONCAT
	2.16 REAL_AS_FLOAT
	2.17 TIME_TRUNCATE_FRACTIONAL   # MySQL 8.0 新增的SQL_MODE值
	2.18 NO_AUTO_CREATE_USER
	2.19 STRICT_ALL_TABLES与STRICT_TRANS_TABLES的区别
	2.20 SQL_MODE的常见组合
	
3. MySQL 5.7 下的两个问题
4. 不同版本默认的SQL_MODE
5. 如何修改SQL_MODE
6. 测试环境和生产环境的SQL_MODE
7. 总结
8. 相关参考


1. SQL_MODE简介
	SQL_MODE是MySQL中的一个系统变量（variable），可由多个MODE组成，每个MODE控制一种行为，如是否允许除数为0，日期中是否允许'0000-00-00'值, group by 列是否允许不出现在查询字段中。
	SQL_MODE的严格模式： 所谓的严格模式，即SQL_MODE中开启了STRICT_ALL_TABLES或STRICT_TRANS_TABLES。
	
2. SQL_MODE的完整列表即每个参数的含义和使用
	
	2.1 ALLOW_INVALID_DATES
		在严格模式下，对于日期的检测较为严格，其必须有效。
		若开启该MODE，对于month和day的检测会相对宽松。其中，month只需在1~12之间，day只需在1~31之间，而不管其是否有效，如下面的'2004-02-31'。
		注意，该MODE只适用于DATE和DATETIME，不适用于TIMESTAMP.
		
			create table t_2139 (c1 datetime);
			set session sql_mode='STRICT_TRANS_TABLES';
			insert into t_2139 values('2004-02-31');
			set session sql_mode='STRICT_TRANS_TABLES,ALLOW_INVALID_DATES';
			insert into t_2139 values('2004-02-31');
			select * from t;

		
			root@mysqldb 06:43:  [db1]> create table t_2139 (c1 datetime);
			 t;Query OK, 0 rows affected (0.09 sec)

			root@mysqldb 06:43:  [db1]> set session sql_mode='STRICT_TRANS_TABLES';
			Query OK, 0 rows affected, 1 warning (0.00 sec)

			root@mysqldb 06:43:  [db1]> insert into t_2139 values('2004-02-31');
			ERROR 1292 (22007): Incorrect datetime value: '2004-02-31' for column 'c1' at row 1
			
			root@mysqldb 06:43:  [db1]> set session sql_mode='STRICT_TRANS_TABLES,ALLOW_INVALID_DATES';
			Query OK, 0 rows affected, 1 warning (0.00 sec)

			root@mysqldb 06:43:  [db1]> insert into t_2139 values('2004-02-31');
			Query OK, 1 row affected (0.01 sec)

			root@mysqldb 06:43:  [db1]> select * from t;
			ERROR 1146 (42S02): Table 'db1.t' doesnt exist
			root@mysqldb 06:43:  [db1]> select * from t_2139;
			ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'from_2139' at line 1
			root@mysqldb 06:43:  [db1]> select * from t_2139;
			+---------------------+
			| c1                  |
			+---------------------+
			| 2004-02-31 00:00:00 |
			+---------------------+
			1 row in set (0.00 sec)

	2.2 ANSI_QUOTES
		在MySQL中，对于关键字和保留字，是不允许用做表名和字段名的。如果一定要使用，必须使用反引号（"`"）进行转义。

			create table order (id int);
			create table `order` (id int);
				
			root@mysqldb 07:45:  [db1]> create table order (id int);
			ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'order (id int)' at line 1
			root@mysqldb 07:45:  [db1]> create table `order` (id int);
			Query OK, 0 rows affected (0.05 sec)
			
			
		若开启该MODE，则双引号，同反引号一样，可对关键字和保留字转义。
		需要注意的是，在开启该MODE的情况下，不能再用双引号来引字符串。
			drop table `order`;
			set session sql_mode='';
			create table "order" (c1 int);

			root@mysqldb 07:45:  [db1]> drop table `order`;
			Query OK, 0 rows affected (0.06 sec)

			root@mysqldb 07:46:  [db1]> set session sql_mode='';
			Query OK, 0 rows affected (0.00 sec)
			
			root@mysqldb 07:46:  [db1]> create table "order" (c1 int);
			ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '"order" (c1 int)' at line 1
		
			
			set session sql_mode='ANSI_QUOTES';
			create table "order" (c1 int);
			
			root@mysqldb 07:47:  [db1]> set session sql_mode='ANSI_QUOTES';
			Query OK, 0 rows affected (0.00 sec)

			root@mysqldb 07:47:  [db1]> create table "order" (c1 int);
			Query OK, 0 rows affected (0.05 sec)
			
	2.3 ERROR_FOR_DIVISION_BY_ZERO
	
		在严格模式，在INSERT或UPDATE过程中，如果被零除(或MOD(X，0))，则产生错误(否则为警告)。如果未给出该模式，被零除时MySQL返回NULL。如果用到INSERT IGNORE或UPDATE IGNORE中，MySQL生成被零除警告，但操作结果为NULL。
		
		该MODE决定除数为0的处理逻辑，实际效果还取决于是否开启严格模式。
		
		1. 开启严格模式，且开启该MODE，插入1/0，会直接报错。
			create table t2245 (c1 double);
			set session sql_mode='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO';
			insert into t2245 values(1/0);
			
			
			root@mysqldb 09:02:  [db1]> create table t2245 (c1 double);
			Query OK, 0 rows affected (0.04 sec)

			root@mysqldb 09:02:  [db1]> set session sql_mode='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO';
			Query OK, 0 rows affected, 1 warning (0.00 sec)

			root@mysqldb 09:02:  [db1]> insert into t2245 values(1/0);
			ERROR 1365 (22012): Division by 0

		2. 只开启严格模式，不开启该MODE，允许1/0的插入，且不提示warning，1/0最后会转化为NULL。
			set session sql_mode='STRICT_TRANS_TABLES';
			insert into t2245 values(1/0);
			select * from t2245;

			root@mysqldb 09:25:  [db1]> set session sql_mode='STRICT_TRANS_TABLES';
			Query OK, 0 rows affected, 1 warning (0.00 sec)

			root@mysqldb 09:25:  [db1]> insert into t2245 values(1/0);
			Query OK, 1 row affected (0.01 sec)
			
			root@mysqldb 09:26:  [db1]> select * from t2245;
			+------+
			| c1   |
			+------+
			| NULL |
			+------+
			1 row in set (0.00 sec)
		
		3. 不开启严格模式，只开启该MODE，允许1/0的插入，但提示warning。
			drop table t2245;
			create table t2245 (c1 double);
			set session sql_mode='ERROR_FOR_DIVISION_BY_ZERO';
			insert into t2245 values(1/0);

			root@mysqldb 09:28:  [db1]> drop table t2245;
			Query OK, 0 rows affected (0.02 sec)

			root@mysqldb 09:28:  [db1]> create table t2245 (c1 double);
			Query OK, 0 rows affected (0.04 sec)

			root@mysqldb 09:28:  [db1]> set session sql_mode='ERROR_FOR_DIVISION_BY_ZERO';
			Query OK, 0 rows affected, 1 warning (0.00 sec)

			root@mysqldb 09:28:  [db1]> insert into t2245 values(1/0);
			Query OK, 1 row affected, 1 warning (0.00 sec)

			root@mysqldb 09:28:  [db1]> show warnings;
			+---------+------+---------------+
			| Level   | Code | Message       |
			+---------+------+---------------+
			| Warning | 1365 | Division by 0 |
			+---------+------+---------------+
			1 row in set (0.00 sec)

			root@mysqldb 09:28:  [db1]> select * from t2245;
			+------+
			| c1   |
			+------+
			| NULL |
			+------+
			1 row in set (0.00 sec)		

		4. 不开启严格模式，也不开启该MODE，允许1/0的插入，且不提示warning，同2一样。
			drop table t2245;
			create table t2245 (c1 double);
			set session sql_mode='';
			insert into t2245 values(1/0);		

			root@mysqldb 09:29:  [db1]> drop table t2245;
			Query OK, 0 rows affected (0.03 sec)

			root@mysqldb 09:29:  [db1]> create table t2245 (c1 double);
			Query OK, 0 rows affected (0.03 sec)

			root@mysqldb 09:29:  [db1]> set session sql_mode='';
			Query OK, 0 rows affected (0.00 sec)

			root@mysqldb 09:29:  [db1]> insert into t2245 values(1/0);
			Query OK, 1 row affected (0.01 sec)

			root@mysqldb 09:29:  [db1]> select * from t2245;
			+------+
			| c1   |
			+------+
			| NULL |
			+------+
			1 row in set (0.00 sec)
		
			
	2.4 HIGH_NOT_PRECEDENCE
		high_not_precedence
		默认情况下，NOT的优先级低于比较运算符。但在某些低版本中，NOT的优先级高于比较运算符。
		看看两者的区别。

		set session sql_mode='';
		select not 1 < -1;
		root@mysqldb 18:14:  [db1]> set session sql_mode='';
		Query OK, 0 rows affected (0.01 sec)

		root@mysqldb 18:14:  [db1]> select not 1 < -1;
		+------------+
		| not 1 < -1 |
		+------------+
		|          1 |
		+------------+
		1 row in set (0.00 sec)
		
		
		
		set session sql_mode='HIGH_NOT_PRECEDENCE';
		select not 1 < -1;

		root@mysqldb 18:14:  [db1]> 
		root@mysqldb 18:14:  [db1]> set session sql_mode='HIGH_NOT_PRECEDENCE';
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 18:14:  [db1]> select not 1 < -1;
		+------------+
		| not 1 < -1 |
		+------------+
		|          0 |
		+------------+
		1 row in set (0.00 sec)
				
		可以看到，在sql_mode为空的情况下， not 的优先级低于比较运算符 即 not 1 < -1相当于not (1 < -1) ；
		如果设置了'HIGH_ NOT_PRECEDENCE'， 则 not 的优先级高于比较运算符 即 相当于(not 1) < -1。
				
	2.5 IGNORE_SPACE
		默认情况下，函数名和左括号（“(”）之间不允许存在空格。若开启该MODE，则允许。

		set session sql_mode='';
		select count(*) from t1;
		select count (*) from t1;
		set session sql_mode='IGNORE_SPACE';
		select count (*) from t1;

		root@mysqldb 18:24:  [db1]> set session sql_mode='';
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 18:24:  [db1]> select count(*) from t1;
		+----------+
		| count(*) |
		+----------+
		|     1000 |
		+----------+
		1 row in set (0.02 sec)

		root@mysqldb 18:24:  [db1]> select count (*) from t1;
		ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '*) from t1' at line 1
		
		
		root@mysqldb 18:24:  [db1]> set session sql_mode='IGNORE_SPACE';
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 18:24:  [db1]> select count (*) from t1;
		+-----------+
		| count (*) |
		+-----------+
		|      1000 |
		+-----------+
		1 row in set (0.00 sec)

	
	2.6 NO_AUTO_VALUE_ON_ZERO
		默认情况下，在对自增主键插入NULL或0时，会自动生成下一个值。若开启该MODE，当插入0时，并不会自动生成下一个值。
		如果表中自增主键列存在0值，在进行逻辑备份还原时，可能会导致数据不一致。所以mysqldump在生成备份数据之前，会自动开启该MODE，以避免数据不一致的情况。
		drop table t;
		create table t (id int auto_increment primary key);
		
		set session sql_mode='';
		insert into t values (0);
		select * from t;
		
		root@mysqldb 23:02:  [db1]> create table t (id int auto_increment primary key);
		Query OK, 0 rows affected (0.08 sec)

		root@mysqldb 23:02:  [db1]> 
		root@mysqldb 23:02:  [db1]> set session sql_mode='';
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 23:02:  [db1]> insert into t values (0);
		Query OK, 1 row affected (0.00 sec)

		root@mysqldb 23:02:  [db1]> select * from t;
		+----+
		| id |
		+----+
		|  1 |
		+----+
		1 row in set (0.00 sec)
	
		
		set session sql_mode='NO_AUTO_VALUE_ON_ZERO';
		insert into t values (0);
		select * from t;
		
		root@mysqldb 23:03:  [db1]> set session sql_mode='NO_AUTO_VALUE_ON_ZERO';
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 23:03:  [db1]> insert into t values (0);
		Query OK, 1 row affected (0.02 sec)

		root@mysqldb 23:03:  [db1]> select * from t;
		+----+
		| id |
		+----+
		|  0 |
		|  1 |
		+----+
		2 rows in set (0.00 sec)

	2.7 NO_BACKSLASH_ESCAPES
		默认情况下，反斜杠“\”会作为转义符，若开启该MODE，则反斜杠“\”会作为一个普通字符，而不是转义符。
		
		set session sql_mode='';
		select '\\t';

		set session sql_mode='NO_BACKSLASH_ESCAPES';
		select '\\t';

		root@mysqldb 23:07:  [db1]> set session sql_mode='';
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 23:07:  [db1]> select '\\t';
		+----+
		| \t |
		+----+
		| \t |
		+----+
		1 row in set (0.00 sec)

		root@mysqldb 23:07:  [db1]> set session sql_mode='NO_BACKSLASH_ESCAPES';
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 23:07:  [db1]> select '\\t';
		+-----+
		| \\t |
		+-----+
		| \\t |
		+-----+
		1 row in set (0.00 sec)
	
	2.8 NO_DIR_IN_CREATE
		默认情况下，在创建表时，可以指定数据目录（DATA DIRECTORY）和索引目录（INDEX DIRECTORY），若开启该MODE，则会忽略这两个选项。
		在主从复制场景下，可在从库上开启该MODE。
		
		drop table t;
				
		set session sql_mode='';
		create table t (id int) data directory '/tmp/';
		show create table t\G;

		root@mysqldb 23:11:  [db1]> drop table t;
		Query OK, 0 rows affected (0.04 sec)

		root@mysqldb 23:11:  [db1]> 
		root@mysqldb 23:11:  [db1]> set session sql_mode='';
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 23:11:  [db1]> create table t (id int) data directory '/tmp/';
		Query OK, 0 rows affected (0.02 sec)

		root@mysqldb 23:11:  [db1]> show create table t\G;
		*************************** 1. row ***************************
			   Table: t
		Create Table: CREATE TABLE `t` (
		  `id` int(11) DEFAULT NULL
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DATA DIRECTORY='/tmp/'
		1 row in set (0.01 sec)

		
		set session sql_mode='NO_DIR_IN_CREATE';
		drop table t;
		create table t (id int) data directory '/tmp/';
		show create table t\G;
		root@mysqldb 23:12:  [db1]> 
		root@mysqldb 23:12:  [db1]> set session sql_mode='NO_DIR_IN_CREATE';
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 23:12:  [db1]> drop table t;
		Query OK, 0 rows affected (0.03 sec)

		root@mysqldb 23:12:  [db1]> create table t (id int) data directory '/tmp/';
		Query OK, 0 rows affected, 1 warning (0.03 sec)

		root@mysqldb 23:12:  [db1]> show create table t\G;
		*************************** 1. row ***************************
			   Table: t
		Create Table: CREATE TABLE `t` (
		  `id` int(11) DEFAULT NULL
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
		1 row in set (0.00 sec)

	2.9 NO_ENGINE_SUBSTITUTION

		在使用CREATE TABLE或者ALTER TABLE语法执行存储引擎的时候，如果设定的存储引擎被禁用或者未编译，会产生错误。

		在开启该MODE的情况下，在创建表时，如果指定的存储引擎不存在或不支持，则会直接提示“ERROR”。
		若不开启，则只会提示“Warning”，且使用默认的存储引擎。
		
		root@mysqldb 08:53:  [db1]> show engines;
		+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
		| Engine             | Support | Comment                                                        | Transactions | XA   | Savepoints |
		+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
		| InnoDB             | DEFAULT | Supports transactions, row-level locking, and foreign keys     | YES          | YES  | YES        |
		| CSV                | YES     | CSV storage engine                                             | NO           | NO   | NO         |
		| MyISAM             | YES     | MyISAM storage engine                                          | NO           | NO   | NO         |
		| BLACKHOLE          | YES     | /dev/null storage engine (anything you write to it disappears) | NO           | NO   | NO         |
		| PERFORMANCE_SCHEMA | YES     | Performance Schema                                             | NO           | NO   | NO         |
		| MRG_MYISAM         | YES     | Collection of identical MyISAM tables                          | NO           | NO   | NO         |
		| ARCHIVE            | YES     | Archive storage engine                                         | NO           | NO   | NO         |
		| MEMORY             | YES     | Hash based, stored in memory, useful for temporary tables      | NO           | NO   | NO         |
		| FEDERATED          | NO      | Federated MySQL storage engine                                 | NULL         | NULL | NULL       |
		+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
		9 rows in set (0.00 sec)
		
		set session sql_mode='';
		create table t100 (id int) engine=federated;
		show warnings;
		show create table t100\G;
		 
		 
		root@mysqldb 08:55:  [db1]>  set session sql_mode='';
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 08:55:  [db1]>  create table t100 (id int) engine=federated;
		Query OK, 0 rows affected, 2 warnings (0.04 sec)

		root@mysqldb 08:55:  [db1]>  show warnings;
		+---------+------+----------------------------------------------+
		| Level   | Code | Message                                      |
		+---------+------+----------------------------------------------+
		| Warning | 1286 | Unknown storage engine 'federated'           |
		| Warning | 1266 | Using storage engine InnoDB for table 't100' |
		+---------+------+----------------------------------------------+
		2 rows in set (0.00 sec)

		root@mysqldb 08:55:  [db1]>  show create table t100\G;
		*************************** 1. row ***************************
			   Table: t100
		Create Table: CREATE TABLE `t100` (
		  `id` int(11) DEFAULT NULL
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
		1 row in set (0.00 sec)

		ERROR: 
		No query specified
		
		# 使用了默认的InnoDB存储引擎

		drop table t100;
		set session sql_mode='NO_ENGINE_SUBSTITUTION';
		create table t100 (id int) engine=federated;
		 
		root@mysqldb 08:55:  [db1]> drop table t100;
		Query OK, 0 rows affected (0.04 sec)

		root@mysqldb 08:55:  [db1]> set session sql_mode='NO_ENGINE_SUBSTITUTION';
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 08:55:  [db1]> create table t100 (id int) engine=federated;
		ERROR 1286 (42000): Unknown storage engine 'federated'		 	
	
	2.10 NO_UNSIGNED_SUBTRACTION
		两个整数相减，如果其中一个数是无符号位，默认情况下，会产生一个无符号位的值，如果该值为负数，则会提示“ERROR”。如，
			drop table t; 
			
			CREATE TABLE t ( a INT UNSIGNED, b INT UNSIGNED )ENGINE=INNODB;
			INSERT INTO t SELECT 1,2;
			SELECT * FROM t; 
		
			set session sql_mode='';
			SELECT a - b FROM t;
				
			root@mysqldb 23:19:  [db1]> set session sql_mode='';
			Query OK, 0 rows affected (0.00 sec)

			root@mysqldb 23:19:  [db1]> SELECT a - b FROM t;
			ERROR 1690 (22003): BIGINT UNSIGNED value is out of range in '(`db1`.`t`.`a` - `db1`.`t`.`b`)'
						
		若开启该MODE，则允许结果为负数。
		
			set session sql_mode='NO_UNSIGNED_SUBTRACTION';
			SELECT a - b FROM t;
			
			root@mysqldb 23:20:  [db1]> set session sql_mode='NO_UNSIGNED_SUBTRACTION';
			Query OK, 0 rows affected (0.00 sec)

			root@mysqldb 23:20:  [db1]> SELECT a - b FROM t;
			+-------+
			| a - b |
			+-------+
			|    -1 |
			+-------+
			1 row in set (0.00 sec)
		
		
		相关参考: https://www.cnblogs.com/blankqdb/archive/2012/11/03/blank_qdb.html
	
	2.11 NO_ZERO_DATE
		在严格模式，不要将’0000-00-00’做为合法日期。你仍然可以用IGNORE选项插入零日期。在非严格模式，可以接受该日期，但会生成警告。
		在开启严格模式，且同时开启该MODE，是不允许'0000-00-00'插入的。
			

		create table t_20201213(c1 datetime);
		STRICT_TRANS_TABLES,NO_ZERO_DATE
			在开启严格模式，且同时开启该MODE，是不允许'0000-00-00'插入的。
			
			set session sql_mode='STRICT_TRANS_TABLES,NO_ZERO_DATE';
			show warnings\G;
			insert into t_20201213 values ('0000-00-00');
			
			root@mysqldb 08:19:  [db1]> create table t_20201213(c1 datetime);
			Query OK, 0 rows affected (0.04 sec)

			root@mysqldb 08:19:  [db1]> set session sql_mode='STRICT_TRANS_TABLES,NO_ZERO_DATE';
			Query OK, 0 rows affected, 1 warning (0.00 sec)

			root@mysqldb 08:19:  [db1]> show warnings\G;
			*************************** 1. row ***************************
			  Level: Warning
			   Code: 3135
			Message: 'NO_ZERO_DATE', 'NO_ZERO_IN_DATE' and 'ERROR_FOR_DIVISION_BY_ZERO' sql modes should be used with strict mode. They will be merged with strict mode in a future release.
			1 row in set (0.00 sec)

			ERROR: 
			No query specified

			root@mysqldb 08:19:  [db1]> insert into t_20201213 values ('0000-00-00');
			ERROR 1292 (22007): Incorrect datetime value: '0000-00-00' for column 'c1' at row 1

		STRICT_TRANS_TABLES
			只开启严格模式，不开启该MODE，允许'0000-00-00'值的插入，且不提示warning。
			
			set session sql_mode='STRICT_TRANS_TABLES';
			show warnings\G
			insert into t_20201213 values ('0000-00-00');
			select * from t_20201213;
			
			root@mysqldb 08:19:  [db1]> set session sql_mode='STRICT_TRANS_TABLES';
			Query OK, 0 rows affected, 1 warning (0.00 sec)

			root@mysqldb 08:20:  [db1]> show warnings\G
			*************************** 1. row ***************************
			  Level: Warning
			   Code: 3135
			Message: 'NO_ZERO_DATE', 'NO_ZERO_IN_DATE' and 'ERROR_FOR_DIVISION_BY_ZERO' sql modes should be used with strict mode. They will be merged with strict mode in a future release.
			1 row in set (0.00 sec)

			root@mysqldb 08:20:  [db1]> insert into t_20201213 values ('0000-00-00');
			Query OK, 1 row affected (0.01 sec)

			root@mysqldb 08:21:  [db1]> select * from t_20201213;
			+---------------------+
			| c1                  |
			+---------------------+
			| 0000-00-00 00:00:00 |
			+---------------------+
			1 row in set (0.00 sec)
		
		NO_ZERO_DATE
			不开启严格模式，只开启该MODE，允许'0000-00-00'值的插入，但提示warning。
			set session sql_mode='NO_ZERO_DATE';
			insert into t_20201213 values ('0000-00-00');
			show warnings;

			root@mysqldb 08:47:  [db1]> set session sql_mode='NO_ZERO_DATE';
			Query OK, 0 rows affected, 1 warning (0.00 sec)

			root@mysqldb 08:47:  [db1]> insert into t_20201213 values ('0000-00-00');
			Query OK, 1 row affected, 1 warning (0.02 sec)

			root@mysqldb 08:47:  [db1]> show warnings;
			+---------+------+---------------------------------------------+
			| Level   | Code | Message                                     |
			+---------+------+---------------------------------------------+
			| Warning | 1264 | Out of range value for column 'c1' at row 1 |
			+---------+------+---------------------------------------------+
			1 row in set (0.01 sec)
						
		不开启严格模式，也不开启该MODE，允许'0000-00-00'值的插入，且不提示warning。
			set session sql_mode='';
			insert into t_20201213 values ('0000-00-00');
			
			root@mysqldb 08:48:  [db1]> set session sql_mode='';
			Query OK, 0 rows affected (0.00 sec)

			root@mysqldb 08:49:  [db1]> insert into t_20201213 values ('0000-00-00');
			Query OK, 1 row affected (0.01 sec)

			
	2.12 NO_ZERO_IN_DATE
		同 NO_ZERO_DATE 类似，只不过 NO_ZERO_DATE 针对的是'0000-00-00'，而 NO_ZERO_IN_DATE 针对的是年不为0，但月或者日为0的日期，如，'2010-00-01' or '2010-01-00'。
		实际效果也是取决于是否开启严格模式，同NO_ZERO_DATE一样。
		
	
	2.13 ONLY_FULL_GROUP_BY
	
		在严格模式下，不要让GROUP BY部分中的查询指向未选择的列，否则报错。
		
		set session sql_mode='ONLY_FULL_GROUP_BY';
		
		CREATE TABLE `t_group_by` (
		  `id` int(11) NOT NULL,
		  `city` varchar(16) NOT NULL,
		  `name` varchar(16) NOT NULL,
		  `age` int(11) NOT NULL,
		  PRIMARY KEY (`id`) 
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
		
		select name from `t_group_by` group by city;
		
		root@mysqldb 08:29:  [db1]> select name from `t_group_by` group by city;
		ERROR 1055 (42000): Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'db1.t_group_by.name' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
		
	2.14 PAD_CHAR_TO_FULL_LENGTH
	
		在对CHAR字段进行存储时，在Compact格式下，会占用固定长度的字节。

		如下面的c1列，定义为char(10)，虽然'ab'只占用两个字节，但在Compact格式下，会占用10个字节，不足部分以空格填充。
		在查询时，默认情况下，会剔除掉末尾的空格。若开启该MODE，则不会剔除，每次都会返回固定长度的字符。

		drop table t;		
		create table t (c1 char(10));
		root@mysqldb 00:04:  [db1]> show create table t\G;
		*************************** 1. row ***************************
			   Table: t
		Create Table: CREATE TABLE `t` (
		  `c1` char(10) DEFAULT NULL
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
		1 row in set (0.00 sec)

		insert into t values('ab');
		
		sql_mode='';	
			set session sql_mode='';
			select c1, hex(c1), char_length(c1) from t;
			
			root@mysqldb 00:04:  [db1]> set session sql_mode='';
			Query OK, 0 rows affected (0.00 sec)

			root@mysqldb 00:05:  [db1]> select c1, hex(c1), char_length(c1) from t;
			+------+---------+-----------------+
			| c1   | hex(c1) | char_length(c1) |
			+------+---------+-----------------+
			| ab   | 6162    |               2 |
			+------+---------+-----------------+
			1 row in set (0.00 sec)
	
		sql_mode='PAD_CHAR_TO_FULL_LENGTH';
			set session sql_mode='PAD_CHAR_TO_FULL_LENGTH';
			select c1, hex(c1), char_length(c1) from t;

			root@mysqldb 00:05:  [db1]> set session sql_mode='PAD_CHAR_TO_FULL_LENGTH';
			Query OK, 0 rows affected (0.00 sec)

			root@mysqldb 00:05:  [db1]> select c1, hex(c1), char_length(c1) from t;
			+------------+----------------------+-----------------+
			| c1         | hex(c1)              | char_length(c1) |
			+------------+----------------------+-----------------+
			| ab         | 61622020202020202020 |              10 |
			+------------+----------------------+-----------------+
			1 row in set (0.00 sec)	
		
		
	2.15 PIPES_AS_CONCAT

		在Oracle中，连接字符串可用concat和管道符（"||"），但concat只能连接两个字符串（MySQL中的concat可连接多个字符），局限性太大，如果要连接多个字符串，一般用的是管道符。

		开启该MODE，即可将管道符作为连接符。
		
		set session sql_mode='';
		select 'a'||'b';
		select concat('a','b');

		root@mysqldb 00:06:  [db1]> 
		root@mysqldb 00:06:  [db1]> set session sql_mode='';
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 00:06:  [db1]> select 'a'||'b';
		+----------+
		| 'a'||'b' |
		+----------+
		|        0 |
		+----------+
		1 row in set, 2 warnings (0.00 sec)

		root@mysqldb 00:06:  [db1]> select concat('a','b');
		+-----------------+
		| concat('a','b') |
		+-----------------+
		| ab              |
		+-----------------+
		1 row in set (0.00 sec)


		set session sql_mode='PIPES_AS_CONCAT';
		select 'a'||'b';

		root@mysqldb 00:06:  [db1]> set session sql_mode='PIPES_AS_CONCAT';
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 00:06:  [db1]> select 'a'||'b';
		+----------+
		| 'a'||'b' |
		+----------+
		| ab       |
		+----------+
		1 row in set (0.00 sec)
	
	
	2.16 REAL_AS_FLOAT
	
		在创建表时，数据类型可指定为real，默认情况下，其会转化为double，若开启该MODE，则会转化为 float 。

		set session sql_mode='';
		create table t ( c1 real);
		show create table t\G;
		drop table t;
		set session sql_mode='REAL_AS_FLOAT';
		create table t ( c1 real);
		show create table t\G;
		
		sql_mode='';
			root@mysqldb 00:07:  [db1]> set session sql_mode='';
			Query OK, 0 rows affected (0.00 sec)

			root@mysqldb 00:07:  [db1]> create table t ( c1 real);
			Query OK, 0 rows affected (0.03 sec)

			root@mysqldb 00:07:  [db1]> show create table t\G;
			*************************** 1. row ***************************
				   Table: t
			Create Table: CREATE TABLE `t` (
			  `c1` double DEFAULT NULL
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
			1 row in set (0.00 sec)
			
		sql_mode='REAL_AS_FLOAT';
			root@mysqldb 00:07:  [db1]> set session sql_mode='REAL_AS_FLOAT';
			Query OK, 0 rows affected (0.00 sec)

			root@mysqldb 00:07:  [db1]> create table t ( c1 real);
			Query OK, 0 rows affected (0.05 sec)

			root@mysqldb 00:07:  [db1]> show create table t\G;
			*************************** 1. row ***************************
				   Table: t
			Create Table: CREATE TABLE `t` (
			  `c1` float DEFAULT NULL
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
			1 row in set (0.00 sec)

		
		
	2.17 TIME_TRUNCATE_FRACTIONAL   # MySQL 8.0 新增的值
		在时间类型定义了小数秒的情况下，如果插入的位数大于指定的位数，默认情况下，会四舍五入，若开启了该MODE，则会直接truncate掉。

		create table t_2103 (c1 int,c2 datetime(2));
		
		默认情况下会四舍五入
			set session sql_mode='';
			insert into t_2103 values(1,'2020-02-13 11:12:13.125');
			select * from t_2103;
			
			root@mysqldb 06:12:  [db1]> create table t_2103 (c1 int,c2 datetime(2));
			Query OK, 0 rows affected (0.09 sec)

			root@mysqldb 06:12:  [db1]> 
			root@mysqldb 06:12:  [db1]> set session sql_mode='';
			Query OK, 0 rows affected (0.00 sec)

			root@mysqldb 06:12:  [db1]> insert into t_2103 values(1,'2020-02-13 11:12:13.125');
			Query OK, 1 row affected (0.02 sec)

			root@mysqldb 06:12:  [db1]> select * from t_2103;
			+------+------------------------+
			| c1   | c2                     |
			+------+------------------------+
			|    1 | 2020-02-13 11:12:13.13 |
			+------+------------------------+
			1 row in set (0.00 sec)
		
		开启 TIME_TRUNCATE_FRACTIONAL 会 truncate掉
			create table t_2103 (c1 int,c2 datetime(2));
			set session sql_mode='TIME_TRUNCATE_FRACTIONAL';
			insert into t_2103 values(2,'2020-02-13 11:12:13.125');
			select * from t_2103;
			
			root@mysqldb 03:04:  [test_20191101]> create table t_2103 (c1 int,c2 datetime(2));
			Query OK, 0 rows affected (0.08 sec)

			root@mysqldb 03:04:  [test_20191101]> set session sql_mode='TIME_TRUNCATE_FRACTIONAL';
			Query OK, 0 rows affected (0.00 sec)

			root@mysqldb 03:04:  [test_20191101]> insert into t_2103 values(2,'2020-02-13 11:12:13.125');
			Query OK, 1 row affected (0.02 sec)

			root@mysqldb 03:04:  [test_20191101]> select * from t_2103;
			+------+------------------------+
			| c1   | c2                     |
			+------+------------------------+
			|    2 | 2020-02-13 11:12:13.12 |
			+------+------------------------+
			1 row in set (0.00 sec)

	
	2.18 NO_AUTO_CREATE_USER
		
		在严格模式下，防止GRANT自动创建新用户，除非还指定了密码。
		
		在MySQL 8.0之前，直接授权会隐式创建用户。
		
			set session sql_mode='NO_AUTO_CREATE_USER';
			select host,user from mysql.user where user='u1';
			grant all on *.* to 'u1'@'%' identified by '123';
			show warnings;
			select host,user from mysql.user where user='u1';
			
			mysql> select host,user from mysql.user where user='u1';
			root@mysqldb 02:39:  [db1]> set session sql_mode='NO_AUTO_CREATE_USER';
			Query OK, 0 rows affected, 1 warning (0.00 sec)

			root@mysqldb 02:39:  [db1]> select host,user from mysql.user where user='u1';
			Empty set (0.00 sec)

			root@mysqldb 02:39:  [db1]> grant all on *.* to 'u1'@'%' identified by '123';
			Query OK, 0 rows affected, 1 warning (0.01 sec)

			root@mysqldb 02:39:  [db1]> show warnings;
			+---------+------+------------------------------------------------------------------------------------------------------------------------------------+
			| Level   | Code | Message                                                                                                                            |
			+---------+------+------------------------------------------------------------------------------------------------------------------------------------+
			| Warning | 1287 | Using GRANT for creating new user is deprecated and will be removed in future release. Create new user with CREATE USER statement. |
			+---------+------+------------------------------------------------------------------------------------------------------------------------------------+
			1 row in set (0.00 sec)

			root@mysqldb 02:39:  [db1]> select host,user from mysql.user where user='u1';
			+------+------+
			| host | user |
			+------+------+
			| %    | u1   |
			+------+------+
			1 row in set (0.00 sec)

			
			set session sql_mode='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER';
			select host,user from mysql.user where user='u2';
			grant all on *.* to 'u2'@'%' identified by '123';
			show warnings;
			select host,user from mysql.user where user='u2';
			
			
			root@mysqldb 03:12:  [db1]> set session sql_mode='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER';
			Query OK, 0 rows affected, 1 warning (0.00 sec)

			root@mysqldb 03:12:  [db1]> select host,user from mysql.user where user='u2';
			Empty set (0.00 sec)

			root@mysqldb 03:12:  [db1]> grant all on *.* to 'u2'@'%' identified by '123';
			Query OK, 0 rows affected, 1 warning (0.02 sec)

			root@mysqldb 03:12:  [db1]> show warnings;
			+---------+------+------------------------------------------------------------------------------------------------------------------------------------+
			| Level   | Code | Message                                                                                                                            |
			+---------+------+------------------------------------------------------------------------------------------------------------------------------------+
			| Warning | 1287 | Using GRANT for creating new user is deprecated and will be removed in future release. Create new user with CREATE USER statement. |
			+---------+------+------------------------------------------------------------------------------------------------------------------------------------+
			1 row in set (0.00 sec)

			root@mysqldb 03:12:  [db1]> select host,user from mysql.user where user='u2';
			+------+------+
			| host | user |
			+------+------+
			| %    | u2   |
			+------+------+
			1 row in set (0.01 sec)
			
			
		同样的grant语句，在MySQL 8.0中是会报错的
			
			set session sql_mode='STRICT_TRANS_TABLES';
			grant all on *.* to 'u2046'@'%' identified by '123';
			
			root@mysqldb 02:19:  [(none)]> set session sql_mode='STRICT_TRANS_TABLES';
			Query OK, 0 rows affected, 1 warning (0.00 sec)
			root@mysqldb 02:19:  [(none)]> grant all on *.* to 'u2046'@'%' identified by '123';
			ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'identified by '123'' at line 1

			
		在MySQL 8.0中，已不允许grant语句隐式创建用户，所以，该MODE在8.0中也不存在。
			root@mysqldb 02:15:  [(none)]> select version();
			+-----------+
			| version() |
			+-----------+
			| 8.0.18    |
			+-----------+
			1 row in set (0.00 sec)

			root@mysqldb 02:15:  [(none)]> set session sql_mode='NO_AUTO_CREATE_USER';
			ERROR 1231 (42000): Variable 'sql_mode' can t be set to the value of 'NO_AUTO_CREATE_USER'
			
			
		从字面上看，该MODE是禁止授权时隐式创建用户。但在实际测试过程中，发现其并不能禁止。

			
		其实，该MODE禁止的只是不带 identified by 子句的grant语句，对于带有 identified by 子句的grant语句，其并不会禁止。
		
			set session sql_mode='NO_AUTO_CREATE_USER';
			grant all on *.* to 'u10'@'%';
			
			root@mysqldb 05:55:  [db1]> select version();
			+------------+
			| version()  |
			+------------+
			| 5.7.22-log |
			+------------+
			1 row in set (0.00 sec)				
			root@mysqldb 05:55:  [db1]> set session sql_mode='NO_AUTO_CREATE_USER';
			Query OK, 0 rows affected, 1 warning (0.00 sec)
			root@mysqldb 05:55:  [db1]> grant all on *.* to 'u10'@'%';
			ERROR 1133 (42000): Can t find any matching row in the user table
			
			
			set session sql_mode='STRICT_TRANS_TABLES';
			grant all on *.* to 'u21'@'%';
			
			root@mysqldb 05:58:  [db1]> set session sql_mode='STRICT_TRANS_TABLES';
			Query OK, 0 rows affected, 1 warning (0.00 sec)
			root@mysqldb 05:58:  [db1]> grant all on *.* to 'u21'@'%';
			Query OK, 0 rows affected, 1 warning (0.01 sec)
						
						
			set session sql_mode='';
			grant all on *.* to 'u11'@'%';
			
			root@mysqldb 05:55:  [db1]> set session sql_mode='';
			Query OK, 0 rows affected, 1 warning (0.00 sec)

			root@mysqldb 05:56:  [db1]> grant all on *.* to 'u11'@'%';
			Query OK, 0 rows affected, 1 warning (0.00 sec)

			root@mysqldb 05:56:  [db1]> show warnings;
			+---------+------+------------------------------------------------------------------------------------------------------------------------------------+
			| Level   | Code | Message                                                                                                                            |
			+---------+------+------------------------------------------------------------------------------------------------------------------------------------+
			| Warning | 1287 | Using GRANT for creating new user is deprecated and will be removed in future release. Create new user with CREATE USER statement. |
			+---------+------+------------------------------------------------------------------------------------------------------------------------------------+
			1 row in set (0.00 sec)
		
	
	2.19 STRICT_ALL_TABLES与STRICT_TRANS_TABLES的区别
		
		STRICT_TRANS_TABLES只对事务表开启严格模式，STRICT_ALL_TABLES是对所有表开启严格模式，不仅仅是事务表，还包括非事务表。
		
		STRICT_TRANS_TABLES
			官方解释：
				If a value could not be inserted as given into a transactional table, abort the statement. For a nontransactional table, abort the statement if the value occurs in a single-row statement or the first row of a multiple-row statement. More details are given later in this section.

				As of MySQL 5.7.5, the default SQL mode includes STRICT_TRANS_TABLES.
					
			该选项针对事务性存储引擎生效，对于非事务性存储引擎无效，该选项表示开启strict sql模式。
			在strict sql模式下，在INSERT或者UPDATE语句中，插入或者更新了某个不符合规定的字段值，则会直接报错中断操作。

		
			看下面这个测试。

			对myisam表插入3条数据，其中，第3条数据是空字符串，与定义的int类型不匹配。
			
				create table t_1602 (c1 int) engine=myisam;
				set session sql_mode='STRICT_TRANS_TABLES';
				insert into t_1602 values (1),(2),('');
				show warnings;
				select * from t_1602;
				
				root@mysqldb 01:30:  [db1]> create table t_1602 (c1 int) engine=myisam;
				Query OK, 0 rows affected (0.01 sec)

				root@mysqldb 01:30:  [db1]> set session sql_mode='STRICT_TRANS_TABLES';
				Query OK, 0 rows affected, 1 warning (0.00 sec)

				root@mysqldb 01:30:  [db1]> insert into t_1602 values (1),(2),('');
				Query OK, 3 rows affected, 1 warning (0.01 sec)
				Records: 3  Duplicates: 0  Warnings: 1

				root@mysqldb 01:30:  [db1]> show warnings;
				+---------+------+------------------------------------------------------+
				| Level   | Code | Message                                              |
				+---------+------+------------------------------------------------------+
				| Warning | 1366 | Incorrect integer value: '' for column 'c1' at row 3 |
				+---------+------+------------------------------------------------------+
				1 row in set (0.00 sec)

				root@mysqldb 01:30:  [db1]> select * from t_1602;
				+------+
				| c1   |
				+------+
				|    1 |
				|    2 |
				|    0 |
				+------+
				3 rows in set (0.00 sec)
		
			对InnoDB表插入3条数据，其中，第3条数据是空字符串，与定义的int类型不匹配。
				create table t_1602 (c1 int) engine=InnoDB;
				set session sql_mode='STRICT_TRANS_TABLES';
				insert into t_1602 values (1),(2),('');
				show warnings;
				select * from t_1602;
			
			
				root@mysqldb 01:43:  [db1]> create table t_1602 (c1 int) engine=InnoDB;
				Query OK, 0 rows affected (0.03 sec)

				root@mysqldb 01:43:  [db1]> set session sql_mode='STRICT_TRANS_TABLES';
				Query OK, 0 rows affected, 1 warning (0.00 sec)

				root@mysqldb 01:43:  [db1]> insert into t_1602 values (1),(2),('');
				ERROR 1366 (HY000): Incorrect integer value: '' for column 'c1' at row 3
				root@mysqldb 01:43:  [db1]> show warnings;
				+-------+------+------------------------------------------------------+
				| Level | Code | Message                                              |
				+-------+------+------------------------------------------------------+
				| Error | 1366 | Incorrect integer value: '' for column 'c1' at row 3 |
				+-------+------+------------------------------------------------------+
				1 row in set (0.00 sec)

				root@mysqldb 01:43:  [db1]> select * from t_1602;
				Empty set (0.00 sec)

			
		STRICT_ALL_TABLES
			set session sql_mode='STRICT_ALL_TABLES';
			drop table t_1602;
			create table t_1602 (c1 int) engine=myisam;
			insert into t_1602 values (1),(2),('');
			select * from t_1602;
			
			root@mysqldb 01:32:  [db1]> set session sql_mode='STRICT_ALL_TABLES';
			Query OK, 0 rows affected, 1 warning (0.00 sec)

			root@mysqldb 01:32:  [db1]> drop table t_1602;
			Query OK, 0 rows affected (0.00 sec)

			root@mysqldb 01:32:  [db1]> create table t_1602 (c1 int) engine=myisam;
			Query OK, 0 rows affected (0.00 sec)

			root@mysqldb 01:32:  [db1]> insert into t_1602 values (1),(2),('');
			ERROR 1366 (HY000): Incorrect integer value: '' for column 'c1' at row 3
			root@mysqldb 01:32:  [db1]> select * from t_1602;
			+------+
			| c1   |
			+------+
			|    1 |
			|    2 |
			+------+
			2 rows in set (0.00 sec)
				
					
		可以看到，在表为 myisam 存储引擎的情况下，只有开启STRICT_ALL_TABLES才会报错。
		在表为 InnoDB 存储引擎的情况下，开启 STRICT_TRANS_TABLES 也会报错。
		

	2.20 SQL_MODE的常见组合
					
		在MySQL 5.7中，还可将SQL_MODE设置为ANSI, DB2, MAXDB, MSSQL, MYSQL323, MYSQL40, ORACLE, POSTGRESQL, TRADITIONAL。
		其实，这些MODE只是上述MODE的一种组合，目的是为了和其它数据库兼容。
		在MySQL 8.0中，只支持ANSI和TRADITIONAL这两种组合。
		
		ANSI 等同于 REAL_AS_FLOAT, PIPES_AS_CONCAT,ANSI_QUOTES, IGNORE_SPACE, ONLY_FULL_GROUP_BY。
		set session sql_mode='ANSI';
		show session variables like 'sql_mode';
			
		TRADITIONAL 等同于STRICT_TRANS_TABLES, STRICT_ALL_TABLES,NO_ZERO_IN_DATE, NO_ZERO_DATE, ERROR_FOR_DIVISION_BY_ZERO, NO_ENGINE_SUBSTITUTION。	
					
		set session sql_mode='TRADITIONAL';
		show session variables like 'sql_mode';	
			
				
3. 不同版本默认的SQL_MODE
	
	MySQL 5.5：空

	MySQL 5.6：NO_ENGINE_SUBSTITUTION

	MySQL 5.7：ONLY_FULL_GROUP_BY, STRICT_TRANS_TABLES,NO_ZERO_IN_DATE, NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER, NO_ENGINE_SUBSTITUTION
	
	MySQL 8.0：ONLY_FULL_GROUP_BY, STRICT_TRANS_TABLES,NO_ZERO_IN_DATE, NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION

	
4. MySQL 5.7 下的两个问题

	1、某些GROUP BY的SQL语句无法执行了：

		这是因为MySQL 5.7默认加入了ONLY_FULL_GROUP_BY参数。

	2、创建表时使用日期数据类型指定的默认值为0000-00-00时报错：

		这是因为MySQL 5.7默认加入了 NO_ZERO_DATE 和 NO_ZERO_IN_DATE 参数。

5. 如何修改SQL_MODE
	SQL_MODE既可在全局级别修改，又可在会话级别修改。可指定多个MODE，MODE之间用逗号隔开。
	全局级别：set global sql_mode='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES';
	会话级别：set session sql_mode='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES';

	
6. 测试环境和生产环境的SQL_MODE
	
	测试环境
		STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
		mysql version : 5.6.36-log
		
	生产环境
		mysql> show global variables like '%sql_mode%';
		+---------------+--------------------------------------------+
		| Variable_name | Value                                      |
		+---------------+--------------------------------------------+
		| sql_mode      | STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION |
		+---------------+--------------------------------------------+
		1 row in set (0.00 sec)

		mysql> select version();
		+------------+
		| version()  |
		+------- -----+
		| 5.7.26-log |
		+------------+
		1 row in set (0.00 sec)

7. 总结
	SQL_MODE在非严格模式下，会出现很多意料不到的结果。建议线上开启严格模式。但对于线上老的环境，如果一开始就运行在非严格模式下，切忌直接调整，毕竟两者的差异性还是相当巨大。

	官方默认的SQL_MODE一直在发生变化，MySQL 5.5, 5.6, 5.7就不尽相同，但总体是趋严的，在对数据库进行升级时，其必须考虑默认的SQL_MODE是否需要调整。
	在进行数据库迁移时，可通过调整SQL_MODE来兼容其它数据库的语法。
	
8. 相关参考
	
	https://dev.mysql.com/doc/refman/5.6/en/sql-mode.html  
	
	https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html
	
	https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html
	
	https://mp.weixin.qq.com/s/B6oV315JBMms0nobSTW3Dw   使用MySQL，SQL_MODE有哪些坑，你知道么？

	https://mp.weixin.qq.com/s/_0aYqLhWwadhkb4FLo6KNA   MySQL5.7中的sql_mode默认值

	https://mp.weixin.qq.com/s/WErt9pyddfy3qfDpbW9mDw   MySQL sql_mode应该如何指定

	https://www.cnblogs.com/liukaifeng/p/10103810.html  MySQL 5.7：聊聊sql_mode

	MySQL sql_mode 说明（及处理一起 sql_mode 引发的问题）
		https://segmentfault.com/a/1190000005936172   
		http://seanlook.com/2016/04/22/mysql-sql-mode-troubleshooting/	

	