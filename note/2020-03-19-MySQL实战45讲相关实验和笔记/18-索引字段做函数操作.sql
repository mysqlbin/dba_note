

18 | 为什么这些SQL语句逻辑相同，性能却差异巨大？


 mysql> CREATE TABLE `tradelog` (
   `id` int(11) NOT NULL,
   `tradeid` varchar(32) DEFAULT NULL,
   `operator` int(11) DEFAULT NULL,
   `t_modified` datetime DEFAULT NULL,
   PRIMARY KEY (`id`),
   KEY `tradeid` (`tradeid`),
   KEY `t_modified` (`t_modified`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

 
 
隐式类型转换:
	数据类型转换规则的方法
	数据类型转换，需要走全索引扫描
	
	
	数据类型转换规则的方法:
		看 select “10” > 9 的结果：
			
			1. 如果规则是“将字符串转成数字”，那么就是做数字比较，结果应该是 1；
				
				select “10” > 9 返回的是 1:
					在 MySQL 中，字符串和数字做比较的话，是将字符串转换成数字。
			
			2. 如果规则是“将数字转成字符串”，那么就是做字符串比较，结果应该是 0。
	
	数据类型转换，需要走全索引扫描:	

		
		root@mysqldb 03:08:  [db1]> desc select * from tradelog where tradeid=110717;
		+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
		| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
		+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
		|  1 | SIMPLE      | tradelog | NULL       | ALL  | tradeid       | NULL | NULL    | NULL |    3 |    33.33 | Using where |
		+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
		1 row in set, 3 warnings (0.00 sec)
		交易编号 tradeid 这个字段上，本来就有索引，但是 explain 的结果却显示，这条语句需要走全表扫描。
		tradeid 的字段类型是 varchar(32)，而输入的参数却是整型，所以需要做类型转换。
		
		mysql> select * from tradelog where  CAST(tradid AS signed int) = 110717;
		
		这条语句触发了上面说到的规则：对索引字段做函数操作，优化器会放弃走树搜索功能。
		

案例三：隐式字符编码转换

tradelog表的字符编码为 utf8mb4; 
trade_detail表的字符编码为 utf8; 
		
mysql> CREATE TABLE `trade_detail` (
  `id` int(11) NOT NULL,
  `tradeid` varchar(32) DEFAULT NULL,
  `trade_step` int(11) DEFAULT NULL, /* 操作步骤 */
  `step_info` varchar(32) DEFAULT NULL, /* 步骤信息 */
  PRIMARY KEY (`id`),
  KEY `tradeid` (`tradeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into tradelog values(1, 'aaaaaaaa', 1000, now());
insert into tradelog values(2, 'aaaaaaab', 1000, now());
insert into tradelog values(3, 'aaaaaaac', 1000, now());

insert into trade_detail values(1, 'aaaaaaaa', 1, 'add');
insert into trade_detail values(2, 'aaaaaaaa', 2, 'update');
insert into trade_detail values(3, 'aaaaaaaa', 3, 'commit');
insert into trade_detail values(4, 'aaaaaaab', 1, 'add');
insert into trade_detail values(5, 'aaaaaaab', 2, 'update');
insert into trade_detail values(6, 'aaaaaaab', 3, 'update again');
insert into trade_detail values(7, 'aaaaaaab', 4, 'commit');
insert into trade_detail values(8, 'aaaaaaac', 1, 'add');
insert into trade_detail values(9, 'aaaaaaac', 2, 'update');
insert into trade_detail values(10, 'aaaaaaac', 3, 'update again');
insert into trade_detail values(11, 'aaaaaaac', 4, 'commit');

样例一:  被驱动表的索引字段上加函数操作
	驱动表的关联字段的字符编码 utf8mb4
	被驱动表的字符编码 utf8
	
要查询 id=2 的交易的所有操作步骤信息:
	
	查看执行计划:
	mysql> desc select d.* from tradelog l, trade_detail d where d.tradeid=l.tradeid and l.id=2;
	+----+-------------+-------+------------+-------+-----------------+---------+---------+-------+------+----------+-------------+
	| id | select_type | table | partitions | type  | possible_keys   | key     | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+-------+------------+-------+-----------------+---------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | l     | NULL       | const | PRIMARY,tradeid | PRIMARY | 4       | const |    1 |   100.00 | NULL        |
	|  1 | SIMPLE      | d     | NULL       | ALL   | NULL            | NULL    | NULL    | NULL  |   11 |   100.00 | Using where |
	+----+-------------+-------+------------+-------+-----------------+---------+---------+-------+------+----------+-------------+
	2 rows in set, 1 warning (0.00 sec)
	

	优化:
	mysql> desc select d.* from tradelog l , trade_detail d where d.tradeid=CONVERT(l.tradeid USING utf8) and l.id=2; 
	+----+-------------+-------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
	| id | select_type | table | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
	+----+-------------+-------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
	|  1 | SIMPLE      | l     | NULL       | const | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | NULL  |
	|  1 | SIMPLE      | d     | NULL       | ref   | tradeid       | tradeid | 99      | const |    4 |   100.00 | NULL  |
	+----+-------------+-------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
	2 rows in set, 1 warning (0.00 sec)


