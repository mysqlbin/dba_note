
1. 表结构和数据的初始化
2. idx_name_birthday_phone_number联合索引的索引组织顺序
3. 全值匹配
	3.1 WHERE子句中的几个搜索条件的顺序跟联合索引的字段顺序一致
	3.2 WHERE子句中的几个搜索条件的顺序跟联合索引的字段顺序不一致
4. 匹配左边的列
5. 匹配列前缀
6. 匹配范围值
	6.1 样例1
	6.2 样例2
7. 精确匹配某一列并范围匹配另外一列
8. 排序
9. 不可以使用索引进行排序的几种情况
	9.1 ASC、DESC混用不可以使用索引进行排序
	9.2 WHERE子句中出现非排序使用到的索引列 	
	9.3 排序列包含非同一个索引的列
	9.4 排序列使用了复杂的表达式
10. 回表的代价
11. 小结

1. 表结构和数据的初始化
	CREATE TABLE person_info(
		id INT NOT NULL auto_increment,
		name VARCHAR(100) NOT NULL,
		birthday DATE NOT NULL,
		phone_number CHAR(11) NOT NULL,
		country varchar(100) NOT NULL,
		PRIMARY KEY (id),
		KEY idx_name_birthday_phone_number (name, birthday, phone_number)
	);

	INSERT INTO `person_info` (`id`, `name`, `birthday`, `phone_number`, `country`) VALUES ('1', 'Ashburn', '1995-11-27', '13598392232', '1');
	INSERT INTO `person_info` (`id`, `name`, `birthday`, `phone_number`, `country`) VALUES ('2', 'Asa', '1988-11-27', '13928384294', '1');
	INSERT INTO `person_info` (`id`, `name`, `birthday`, `phone_number`, `country`) VALUES ('3', 'Ashburn', '1990-09-27', '15123983239', '1');

	INSERT INTO `person_info` (`id`, `name`, `birthday`, `phone_number`, `country`) VALUES ('4', 'Barlow', '2000-08-12', '13839024132', '1');
	INSERT INTO `person_info` (`id`, `name`, `birthday`, `phone_number`, `country`) VALUES ('5', 'Barlow', '2000-08-12', '15523948321', '1');
	INSERT INTO `person_info` (`id`, `name`, `birthday`, `phone_number`, `country`) VALUES ('6', 'Baird', '1990-09-02', '18639238122', '1');

	INSERT INTO `person_info` (`id`, `name`, `birthday`, `phone_number`, `country`) VALUES ('7', 'Aaron', '1988-07-04', '17623847922', '1');
	INSERT INTO `person_info` (`id`, `name`, `birthday`, `phone_number`, `country`) VALUES ('8', 'Aaron', '1993-05-15', '15123748322', '1');
	INSERT INTO `person_info` (`id`, `name`, `birthday`, `phone_number`, `country`) VALUES ('9', 'Aaron', '1974-08-12', '13474749741', '1');

	root@mysqldb 15:52:  [audit_db]> select * from person_info;
	+----+---------+------------+--------------+---------+
	| id | name    | birthday   | phone_number | country |
	+----+---------+------------+--------------+---------+
	|  1 | Ashburn | 1995-11-27 | 13598392232  | 1       |
	|  2 | Asa     | 1988-11-27 | 13928384294  | 1       |
	|  3 | Ashburn | 1990-09-27 | 15123983239  | 1       |
	|  4 | Barlow  | 2000-08-12 | 13839024132  | 1       |
	|  5 | Barlow  | 2000-08-12 | 15523948321  | 1       |
	|  6 | Baird   | 1990-09-02 | 18639238122  | 1       |
	|  7 | Aaron   | 1988-07-04 | 17623847922  | 1       |
	|  8 | Aaron   | 1993-05-15 | 15123748322  | 1       |
	|  9 | Aaron   | 1974-08-12 | 13474749741  | 1       |
	+----+---------+------------+--------------+---------+
	9 rows in set (0.00 sec)


2. idx_name_birthday_phone_number联合索引的索引组织顺序
	
	root@mysqldb 17:42:  [audit_db]> select name,birthday,phone_number,id from person_info order by name asc,birthday asc, phone_number asc,id asc;
	+---------+------------+--------------+----+
	| name    | birthday   | phone_number | id |
	+---------+------------+--------------+----+
	| Aaron   | 1974-08-12 | 13474749741  |  9 |
	| Aaron   | 1988-07-04 | 17623847922  |  7 |
	| Aaron   | 1993-05-15 | 15123748322  |  8 |
	| Asa     | 1988-11-27 | 13928384294  |  2 |
	| Ashburn | 1990-09-27 | 15123983239  |  3 |
	| Ashburn | 1995-11-27 | 13598392232  |  1 |
	| Baird   | 1990-09-02 | 18639238122  |  6 |
	| Barlow  | 2000-08-12 | 13839024132  |  4 |
	| Barlow  | 2000-08-12 | 15523948321  |  5 |
	+---------+------------+--------------+----+
	9 rows in set (0.00 sec)


	这个idx_name_birthday_phone_number索引对应的B+树中页面和记录的排序方式就是这样的：

		先按照name列的值进行排序。
		如果name列的值相同，则按照birthday列的值进行排序。
		如果birthday列的值也相同，则按照phone_number的值进行排序。
		
		-- 这里要理解，不然后面的笔记很难理解。
		-- 理解了。
		
3. 全值匹配

3.1 WHERE子句中的几个搜索条件的顺序跟联合索引的字段顺序一致

	如果我们的搜索条件中的列和索引列一致的话，这种情况就称为全值匹配
	
	SELECT * FROM person_info WHERE name = 'Ashburn' AND birthday = '1990-09-27' AND phone_number = '15123983239';
	
	mysql> desc SELECT * FROM person_info WHERE name = 'Ashburn' AND birthday = '1990-09-27' AND phone_number = '15123983239';
	+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------------------+------+----------+-------+
	| id | select_type | table       | partitions | type | possible_keys                  | key                            | key_len | ref               | rows | filtered | Extra |
	+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------------------+------+----------+-------+
	|  1 | SIMPLE      | person_info | NULL       | ref  | idx_name_birthday_phone_number | idx_name_birthday_phone_number | 449     | const,const,const |    1 |   100.00 | NULL  |
	+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------------------+------+----------+-------+
	1 row in set, 1 warning (0.00 sec)
	
	建立的idx_name_birthday_phone_number索引包含的3个列在这个查询语句中都展现出来了
	
	查询过程：
	
		1. 因为B+树的数据页和记录先是按照name列的值进行排序的，所以先可以很快定位name列的值是 Ashburn 的记录位置。

		2. 根据B+树索引的记录排序方式，在name列相同的记录里又是按照birthday列的值进行排序的，所以在name列的值是Ashburn的记录里又可以快速定位birthday列的值是'1990-09-27'的记录。

		3. 如果 name和birthday列的值都是相同的，那记录是按照phone_number列的值排序的，所以联合索引中的三个列都可能被用到。

3.2 WHERE子句中的几个搜索条件的顺序跟联合索引的字段顺序不一致

	WHERE子句中的几个搜索条件的顺序对查询结果没有影响
	
	也就是说如果我们调换name、birthday、phone_number这几个搜索列的顺序对查询的执行过程是没有影响的。

	msyql> desc SELECT * FROM person_info WHERE birthday = '1990-09-27' AND phone_number = '15123983239' AND name = 'Ashburn';
	+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------------------+------+----------+-------+
	| id | select_type | table       | partitions | type | possible_keys                  | key                            | key_len | ref               | rows | filtered | Extra |
	+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------------------+------+----------+-------+
	|  1 | SIMPLE      | person_info | NULL       | ref  | idx_name_birthday_phone_number | idx_name_birthday_phone_number | 449     | const,const,const |    1 |   100.00 | NULL  |
	+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------------------+------+----------+-------+
	1 row in set, 1 warning (0.01 sec)
	
	key_len = 449 
	
	name VARCHAR(100) NOT NULL     = 100*4+2=402 
	birthday DATE NOT NULL         = 3
	phone_number CHAR(11) NOT NULL = 11*4= 44
	
	402+3+44 = 449.
	
	
	原因: MySQL有一个叫查询优化器的东东，会分析这些搜索条件并且按照可以使用的索引中列的顺序来决定先使用哪个搜索条件，后使用哪个搜索条件。
		
		
4. 匹配左边的列

	搜索语句中也可以不用包含全部联合索引中的列，只包含左边的就行，比方说下边的查询语句：
	
		SELECT * FROM person_info WHERE name = 'Ashburn';
		
		mysql> desc SELECT * FROM person_info WHERE name = 'Ashburn';
		+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------+------+----------+-------+
		| id | select_type | table       | partitions | type | possible_keys                  | key                            | key_len | ref   | rows | filtered | Extra |
		+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------+------+----------+-------+
		|  1 | SIMPLE      | person_info | NULL       | ref  | idx_name_birthday_phone_number | idx_name_birthday_phone_number | 402     | const |    2 |   100.00 | NULL  |
		+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------+------+----------+-------+
		1 row in set, 1 warning (0.00 sec)


	或者包含多个左边的列也行：
	
		SELECT * FROM person_info WHERE name = 'Ashburn' AND birthday = '1990-09-27';

		mysql> desc SELECT * FROM person_info WHERE name = 'Ashburn' AND birthday = '1990-09-27';
		+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------------+------+----------+-------+
		| id | select_type | table       | partitions | type | possible_keys                  | key                            | key_len | ref         | rows | filtered | Extra |
		+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------------+------+----------+-------+
		|  1 | SIMPLE      | person_info | NULL       | ref  | idx_name_birthday_phone_number | idx_name_birthday_phone_number | 405     | const,const |    1 |   100.00 | NULL  |
		+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------------+------+----------+-------+
		1 row in set, 1 warning (0.00 sec)


	搜索语句没有匹配左边的列：
	
		SELECT * FROM person_info WHERE birthday = '1990-09-27';
		
		mysql> desc SELECT * FROM person_info WHERE birthday = '1990-09-27';
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+-------------+
		| id | select_type | table       | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+-------------+
		|  1 | SIMPLE      | person_info | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    9 |    11.11 | Using where |
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+-------------+
		1 row in set, 1 warning (0.00 sec)

		B+树的数据页和记录先是按照name列的值排序的，在name列的值相同的情况下才使用birthday列进行排序，也就是说name列的值不同的记录中birthday的值可能是无序的。
		
		现在你跳过name列直接根据birthday的值去查找，肯定是不用到索引的。
		
		
	如果我们想使用联合索引中尽可能多的列，搜索条件中的各个列必须是联合索引中从最左边连续的列。	
		
		联合索引idx_name_birthday_phone_number中列的定义顺序是name、birthday、phone_number，如果我们的搜索条件中只有name和phone_number，而没有中间的birthday，比方说这样：	
			
			SELECT * FROM person_info WHERE name = 'Ashburn' AND phone_number = '15123983239';
			
			mysql> desc SELECT * FROM person_info WHERE name = 'Ashburn' AND phone_number = '15123983239';
			+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------+------+----------+-----------------------+
			| id | select_type | table       | partitions | type | possible_keys                  | key                            | key_len | ref   | rows | filtered | Extra                 |
			+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------+------+----------+-----------------------+
			|  1 | SIMPLE      | person_info | NULL       | ref  | idx_name_birthday_phone_number | idx_name_birthday_phone_number | 402     | const |    2 |    11.11 | Using index condition |
			+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------+------+----------+-----------------------+
			1 row in set, 1 warning (0.00 sec)

			这样只能用到name列的索引，birthday和phone_number的索引就用不上了，因为name值相同的记录先按照birthday的值进行排序，birthday值相同的记录才按照phone_number值进行排序。
		
		
5. 匹配列前缀


	为某个列建立索引的意思其实就是在对应的B+树的记录中使用该列的值进行排序存储    --理解。
	比方说person_info表上建立的联合索引idx_name_birthday_phone_number会先用name列的值进行排序，所以这个联合索引对应的B+树中的记录的name列的排列就是这样的：

		Aaron
		Aaron
		...
		Aaron
		Asa
		Ashburn
		...
		Ashburn
		Baird
		Barlow
		...
		Barlow
		
	所以一个排好序的字符串列其实有这样的特点：

		先按照字符串的第一个字符进行排序。

		如果第一个字符相同再按照第二个字符进行排序。

		如果第二个字符相同再按照第三个字符进行排序，依此类推。
		
	也就是说这些字符串的前n个字符，也就是前缀都是排好序的，所以对于字符串类型的索引列来说，我们只匹配它的前缀也是可以快速定位记录的	
	
	
	查询名字以'As'开头的记录：
	
		SELECT * FROM person_info WHERE name LIKE 'As%';
		
	如果只给出后缀或者中间的某个字符串是无法使用到索引的：
		
		SELECT * FROM person_info WHERE name LIKE '%As%';
		
		因为字符串中间有'As'的字符串并没有排好序，所以只能全表扫描了。
	
	倒序存储字长串
	
		有时候我们有一些匹配某些字符串后缀的需求，比方说某个表有一个url列，该列中存储了许多url：
			+----------------+
			| url            |
			+----------------+
			| www.baidu.com  |
			| www.google.com |
			| www.gov.cn     |
			| ...            |
			| www.wto.org    |
			+----------------+
				
		假设已经对该url列创建了索引，如果我们想查询以com为后缀的网址的话可以这样写查询条件：
		
			WHERE url LIKE '%com' 
			但是这样的话无法使用该url列的索引。
		
		可以把后缀查询改写成前缀查询
		
		把表中的数据全部逆序存储一下，也就是说我们可以这样保存url列中的数据：
			+----------------+
			| url            |
			+----------------+
			| moc.udiab.www  |
			| moc.elgoog.www |
			| nc.vog.www     |
			| ...            |
			| gro.otw.www    |
			+----------------+
		
		这样再查找以 com 为后缀的网址时搜索条件便可以这么写：WHERE url LIKE 'moc%'，这样就可以用到索引了。
		
6. 匹配范围值
	
6.1 样例1

	mysql> desc SELECT * FROM person_info WHERE name > 'Asa' AND name < 'Barlow';
	+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
	| id | select_type | table       | partitions | type  | possible_keys                  | key                            | key_len | ref  | rows | filtered | Extra                 |
	+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
	|  1 | SIMPLE      | person_info | NULL       | range | idx_name_birthday_phone_number | idx_name_birthday_phone_number | 402     | NULL |    3 |   100.00 | Using index condition |
	+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
	1 row in set, 1 warning (0.00 sec)
	
	
	name(100) not null = 100*4+2=402 ： 说明用到了 name列的索引

	由于B+树中的数据页和记录是先按name列排序的，所以我们上边的查询过程其实是这样的：

		找到name值为Asa的记录。
		找到name值为Barlow的记录。
		哦啦，由于所有记录都是由链表连起来的（记录之间用单链表，数据页之间用双链表），所以他们之间的记录都可以很容易的取出来喽～
		找到这些记录的主键值，再到聚簇索引中回表查找完整的记录。

		--这里的查询过程要更正。
	
		
6.2 样例2	

	使用联合进行范围查找，如果对多个列同时进行范围查找的话，只有对索引最左边的那个列进行范围查找的时候才能用到B+树索引
	
	mysql> desc SELECT * FROM person_info WHERE name > 'Asa' AND name < 'Barlow' AND birthday > '1980-01-01';
	+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
	| id | select_type | table       | partitions | type  | possible_keys                  | key                            | key_len | ref  | rows | filtered | Extra                 |
	+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
	|  1 | SIMPLE      | person_info | NULL       | range | idx_name_birthday_phone_number | idx_name_birthday_phone_number | 402     | NULL |    3 |    33.33 | Using index condition |
	+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
	1 row in set, 1 warning (0.01 sec)

	root@mysqldb 17:45:  [audit_db]> desc SELECT * FROM person_info WHERE name > 'Asa' AND name < 'Barlow' AND birthday > '1980-01-01' order by birthday asc;
	+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+---------------------------------------+
	| id | select_type | table       | partitions | type  | possible_keys                  | key                            | key_len | ref  | rows | filtered | Extra                                 |
	+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+---------------------------------------+
	|  1 | SIMPLE      | person_info | NULL       | range | idx_name_birthday_phone_number | idx_name_birthday_phone_number | 402     | NULL |    3 |    33.33 | Using index condition; Using filesort |
	+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+---------------------------------------+
	1 row in set, 1 warning (0.00 sec)


	name(100) not null = 100*4+2=402 ： 说明只用到了 name列的索引
	
	上边这个查询可以分成两个部分：

		通过条件name > 'Asa' AND name < 'Barlow'来对name进行范围，查找的结果可能有多条name值不同的记录，

		对这些name值不同的记录继续通过birthday > '1980-01-01'条件继续过滤。
	
	这样子对于联合索引idx_name_birthday_phone_number来说，只能用到name列的部分，而用不到birthday列的部分，
	因为只有name值相同的情况下才能用birthday列的值进行排序，而这个查询中通过name进行范围查找的记录中可能并不是按照birthday列进行排序的，所以在搜索条件中继续以birthday列进行查找时是用不到这个B+树索引的。
		
		验证只有name值相同的情况下才能用birthday列的值进行排序：
			
			root@mysqldb 17:51:  [audit_db]> desc SELECT * FROM person_info WHERE name = 'Ashburn'  AND birthday > '1980-01-01' order by birthday desc;
			+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
			| id | select_type | table       | partitions | type  | possible_keys                  | key                            | key_len | ref  | rows | filtered | Extra                 |
			+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
			|  1 | SIMPLE      | person_info | NULL       | range | idx_name_birthday_phone_number | idx_name_birthday_phone_number | 405     | NULL |    2 |   100.00 | Using index condition |
			+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
			1 row in set, 1 warning (0.00 sec)

			root@mysqldb 18:13:  [audit_db]> desc SELECT * FROM person_info WHERE name = 'Ashburn'  AND birthday > '1980-01-01' order by birthday asc;
			+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
			| id | select_type | table       | partitions | type  | possible_keys                  | key                            | key_len | ref  | rows | filtered | Extra                 |
			+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
			|  1 | SIMPLE      | person_info | NULL       | range | idx_name_birthday_phone_number | idx_name_birthday_phone_number | 405     | NULL |    2 |   100.00 | Using index condition |
			+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
			1 row in set, 1 warning (0.00 sec)
	

7. 精确匹配某一列并范围匹配另外一列
	
	root@mysqldb 18:15:  [audit_db]> desc SELECT * FROM person_info WHERE name = 'Ashburn' AND birthday > '1980-01-01' AND birthday < '2000-12-31' AND phone_number > '15100000000';
	+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
	| id | select_type | table       | partitions | type  | possible_keys                  | key                            | key_len | ref  | rows | filtered | Extra                 |
	+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
	|  1 | SIMPLE      | person_info | NULL       | range | idx_name_birthday_phone_number | idx_name_birthday_phone_number | 405     | NULL |    2 |    33.33 | Using index condition |
	+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
	1 row in set, 1 warning (0.00 sec)

	
	name(100) not null = 100*4+2=402
	birthday DATE NOT NULL = 3
	
	402+3 = 405
	
	这个查询的条件可以分为3个部分：

		name = 'Ashburn'，对name列进行精确查找，当然可以使用B+树索引了。

		birthday > '1980-01-01' AND birthday < '2000-12-31'，由于name列是精确查找，所以通过name = 'Ashburn'条件查找后得到的结果的name值都是相同的，它们会再按照birthday的值进行排序。
			所以此时对birthday列进行范围查找是可以用到B+树索引的。

		phone_number > '15100000000'，通过birthday的范围查找的记录的birthday的值可能不同，所以这个条件无法再利用B+树索引了，只能遍历上一步查询得到的记录。	
		
	因此，下边的查询也是可能用到这个idx_name_birthday_phone_number联合索引的：
	
		SELECT * FROM person_info WHERE name = 'Ashburn' AND birthday = '1980-01-01' AND phone_number > '15100000000';

		root@mysqldb 10:43:  [audit_db]> desc SELECT * FROM person_info WHERE name = 'Ashburn' AND birthday = '1980-01-01' AND phone_number > '15100000000';
		+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
		| id | select_type | table       | partitions | type  | possible_keys                  | key                            | key_len | ref  | rows | filtered | Extra                 |
		+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
		|  1 | SIMPLE      | person_info | NULL       | range | idx_name_birthday_phone_number | idx_name_birthday_phone_number | 449     | NULL |    1 |   100.00 | Using index condition |
		+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
		1 row in set, 1 warning (0.00 sec)

		key_len = 449 
		
		name VARCHAR(100) NOT NULL     = 100*4+2=402 
		birthday DATE NOT NULL         = 3
		phone_number CHAR(11) NOT NULL = 11*4= 44
		
		402+3+44 = 449.

		查询过程：
		
			1. 因为B+树的数据页和记录先是按照name列的值进行排序的，所以先可以很快定位name列的值是 Ashburn 的记录位置。

			2. 根据B+树索引的记录排序方式，在name列相同的记录里又是按照birthday列的值进行排序的，所以在name列的值是Ashburn的记录里又可以快速定位birthday列的值是'1980-01-01'的记录。

			3. 如果 name和birthday列的值都是相同的，那记录是按照phone_number列的值排序的，所以联合索引中的三个列都可能被用到。

8. 排序
	
	经常需要对查询出来的记录通过ORDER BY子句按照某种规则进行排序
	
	一般情况下，我们只能把记录都加载到内存中，再用一些排序算法，比如快速排序、归并排序、吧啦吧啦排序等等在内存中对这些记录进行排序
	
	有的时候可能查询的结果集太大以至于不能在内存中进行排序的话，还可能暂时借助磁盘的空间来存放中间结果，排序操作完成后再把排好序的结果集返回到客户端。
	
	在MySQL中，把这种在内存中或者磁盘上进行排序的方式统称为文件排序（英文名：filesort），跟文件这个词儿一沾边儿，就显得这些排序操作非常慢了
	
	磁盘和内存的速度比起来，就像是飞机和蜗牛的对比
	
	如果ORDER BY子句里使用到了我们的索引列，就有可能省去在内存或文件中排序的步骤，比如下边这个简单的查询语句：
	

		SELECT * FROM person_info ORDER BY name, birthday, phone_number LIMIT 10;

		mysql> desc SELECT * FROM person_info ORDER BY name asc, birthday asc, phone_number asc LIMIT 10;
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
		| id | select_type | table       | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra          |
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
		|  1 | SIMPLE      | person_info | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    9 |   100.00 | Using filesort |
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
		1 row in set, 1 warning (0.00 sec)
		
		-- 二级索引虽然不需要排序但是需要回表，代价比全表扫描需要排序大，所以优化器选择了全表扫描。
		参考笔记 《2020-07-30-optimize.sql》
		
		mysql> desc SELECT name,birthday,phone_number FROM person_info ORDER BY name asc, birthday asc, phone_number asc LIMIT 10;
		+----+-------------+-------------+------------+-------+---------------+--------------------------------+---------+------+------+----------+-------------+
		| id | select_type | table       | partitions | type  | possible_keys | key                            | key_len | ref  | rows | filtered | Extra       |
		+----+-------------+-------------+------------+-------+---------------+--------------------------------+---------+------+------+----------+-------------+
		|  1 | SIMPLE      | person_info | NULL       | index | NULL          | idx_name_birthday_phone_number | 449     | NULL |    9 |   100.00 | Using index |
		+----+-------------+-------------+------------+-------+---------------+--------------------------------+---------+------+------+----------+-------------+
		1 row in set, 1 warning (0.00 sec)

		这个查询的结果集需要先按照name值排序，如果记录的name值相同，则需要按照birthday来排序，如果birthday的值相同，则需要按照phone_number排序。
		
		因为这个B+树索引本身就是按照上述规则排好序的，所以直接从idx_name_birthday_phone_number索引中提取数据 就好了。
	
	
	当联合索引左边列的值为常量，也可以使用后边的列进行排序，比如这样：
	
		mysql> desc SELECT * FROM person_info WHERE name = 'A' ORDER BY birthday, phone_number LIMIT 10;
		+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------+------+----------+-----------------------+
		| id | select_type | table       | partitions | type | possible_keys                  | key                            | key_len | ref   | rows | filtered | Extra                 |
		+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------+------+----------+-----------------------+
		|  1 | SIMPLE      | person_info | NULL       | ref  | idx_name_birthday_phone_number | idx_name_birthday_phone_number | 402     | const |    1 |   100.00 | Using index condition |
		+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------+------+----------+-----------------------+
		1 row in set, 1 warning (0.00 sec)

9. 不可以使用索引进行排序的几种情况

9.1 ASC、DESC混用不可以使用索引进行排序

	ORDER BY子句后的列如果不加ASC或者DESC默认是按照ASC排序规则排序的，也就是升序排序的。

	对于使用联合索引进行排序的场景，我们要求各个排序列的排序顺序是一致的，也就是要么各个列都是ASC规则排序，要么都是DESC规则排序。
	
	如果查询中的各个排序列的排序顺序是一致的，比方说下边这两种情况：

		ORDER BY name, birthday LIMIT 10 : 这种情况直接从索引的最左边开始往右读10行记录就可以了。

		ORDER BY name DESC, birthday DESC LIMIT 10 : 这种情况直接从索引的最右边开始往左读10行记录就可以了。

		
	先按照name列进行升序排列，再按照birthday列进行降序排序
	
		root@mysqldb 12:29:  [audit_db]> desc SELECT * FROM person_info ORDER BY name, birthday DESC LIMIT 1; 
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
		| id | select_type | table       | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra          |
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
		|  1 | SIMPLE      | person_info | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    9 |   100.00 | Using filesort |
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
		1 row in set, 1 warning (0.00 sec)
		
		-- 需要临时表做辅助排序
		
		-- MySQL 8.0 支持降序索引，参考笔记 《2019-10-17-倒序、降序索引.sql》
		
9.2 WHERE子句中出现非排序使用到的索引列 

	如果WHERE子句中出现了非排序使用到的索引列，那么排序依然是使用不到索引的，比方说这样：

		mysql> desc SELECT * FROM person_info WHERE country = 'China' ORDER BY name LIMIT 10;
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+-----------------------------+
		| id | select_type | table       | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra                       |
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+-----------------------------+
		|  1 | SIMPLE      | person_info | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    9 |    11.11 | Using where; Using filesort |
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+-----------------------------+
		1 row in set, 1 warning (0.00 sec)
		
		先把符合 country = 'China' 的记录取出来，再对这些记录做排序。
		

	
	下面的语句可以使得到索引
		mysql> desc SELECT * FROM person_info WHERE name = 'A' ORDER BY birthday, phone_number LIMIT 10;
		+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------+------+----------+-----------------------+
		| id | select_type | table       | partitions | type | possible_keys                  | key                            | key_len | ref   | rows | filtered | Extra                 |
		+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------+------+----------+-----------------------+
		|  1 | SIMPLE      | person_info | NULL       | ref  | idx_name_birthday_phone_number | idx_name_birthday_phone_number | 402     | const |    1 |   100.00 | Using index condition |
		+----+-------------+-------------+------------+------+--------------------------------+--------------------------------+---------+-------+------+----------+-----------------------+
		1 row in set, 1 warning (0.00 sec)

		
		name VARCHAR(100) NOT NULL     = 100*4+2=402 
		
		消除了排序，因为 name = 'A' 是等值查询，查询到的记录默认是先按 birthday排序的，然后再按 phone_number 排序的，所以可以用到索引。
		
9.3 排序列包含非同一个索引的列
	
	来排序的多个列不是一个索引里的，这种情况也不能使用索引进行排序，比方说：
	
		mysql> desc SELECT * FROM person_info ORDER BY name, country LIMIT 1; 
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
		| id | select_type | table       | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra          |
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
		|  1 | SIMPLE      | person_info | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    9 |   100.00 | Using filesort |
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
		1 row in set, 1 warning (0.00 sec)

	name和country并不属于一个联合索引中的列，所以无法使用索引进行排序
	
	这个idx_name_birthday_phone_number索引对应的B+树中页面和记录的排序方式就是这样的：

		先按照name列的值进行排序。
		如果name列的值相同，则按照birthday列的值进行排序。
		如果birthday列的值也相同，则按照phone_number的值进行排序。
		
9.4 排序列使用了复杂的表达式

	要想使用索引进行排序操作，必须保证索引列是以单独列的形式出现，而不是修饰过的形式，比方说这样：

		mysql> desc SELECT * FROM person_info ORDER BY UPPER(name) LIMIT 1;
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
		| id | select_type | table       | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra          |
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
		|  1 | SIMPLE      | person_info | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    9 |   100.00 | Using filesort |
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
		1 row in set, 1 warning (0.00 sec)
		
	使用了 UPPER 函数 修饰过的列就不是单独的列啦，这样就无法使用索引进行排序啦。

	MySQL 的一个规定：对索引字段做函数操作，可能会破坏索引值的有序性，因此优化器就决定放弃走树搜索功能
	
	
		
10. 回表的代价

	SELECT * FROM person_info WHERE name > 'Asa' AND name < 'Barlow';
	
	mysql> desc SELECT * FROM person_info WHERE name > 'Asa' AND name < 'Barlow';
	+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
	| id | select_type | table       | partitions | type  | possible_keys                  | key                            | key_len | ref  | rows | filtered | Extra                 |
	+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
	|  1 | SIMPLE      | person_info | NULL       | range | idx_name_birthday_phone_number | idx_name_birthday_phone_number | 402     | NULL |    3 |   100.00 | Using index condition |
	+----+-------------+-------------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-----------------------+
	1 row in set, 1 warning (0.00 sec)


	顺序I/O：
		
		由于索引idx_name_birthday_phone_number对应的B+树中的记录首先会按照name列的值进行排序，所以值在Asa～Barlow之间的记录在磁盘中的存储是相连的，集中分布在一个或几个数据页中，
		我们可以很快的把这些连着的记录从磁盘中读出来，这种读取方式我们也可以称为顺序I/O。
		
		假设树高为2， 只需要进行从根节点向下查找一次叶子节点（定位），然后对叶子节点的数据页的行记录进行遍历查找。 
		
		
	随机I/O：
		
		SELECT name, id FROM person_info WHERE name > 'Asa' AND name < 'Barlow';

		mysql> SELECT name, id FROM person_info WHERE name > 'Asa' AND name < 'Barlow';
		+---------+----+
		| name    | id |
		+---------+----+
		| Ashburn |  3 |
		| Ashburn |  1 |
		| Baird   |  6 |
		+---------+----+
		3 rows in set (0.00 sec)
		
		二级索引的叶子节点的主键可能并不是连续的，此时根据主键去主键索引树进行查找数据，产生的是随机I/O。
		
		获取到的记录的id字段的值可能并不相连，而在聚簇索引中记录是根据id（也就是主键）的顺序排列的，所以根据这些并不连续的id值到聚簇索引中访问完整的用户记录可能分布在不同的数据页中，
		这样读取完整的用户记录可能要访问更多的数据页，这种读取方式我们也可以称为随机I/O
	
		参考 MRR优化，根据二级索引查询，获取到足够多的主键，再对这些主键进行排序，然后再拿这些主键去主键索引树进行查找数据，因为是根据主键进行顺序访问，所以产生的是顺序I/O。 
		--举一反三的能力。
		
	一般情况下，顺序I/O比随机I/O的性能高很多，所以根据二级索引进行范围查找数据的速度很快，但是根据不连续的主键到主键索引树进行查找数据，效率就没这么高。

	所以这个使用索引 idx_name_birthday_phone_number 的查询有这么两个特点：

		会使用到两个B+树索引，一个二级索引，一个聚簇索引。

		访问二级索引使用顺序I/O，访问聚簇索引使用随机I/O。
		
		-- 验证了回表涉及随机I/O的访问
	
	全表扫描
		
		SELECT * FROM person_info ORDER BY name, birthday, phone_number LIMIT 10;

		mysql> desc SELECT * FROM person_info ORDER BY name asc, birthday asc, phone_number asc LIMIT 10;
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
		| id | select_type | table       | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra          |
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
		|  1 | SIMPLE      | person_info | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    9 |   100.00 | Using filesort |
		+----+-------------+-------------+------------+------+---------------+------+---------+------+------+----------+----------------+
		1 row in set, 1 warning (0.00 sec)
		
		-- 虽然选择二级索引不需要排序但是需要回表，比全表扫描的代价大，所以优化器选择了全表扫描。
		
		参考笔记 《2020-07-30-optimize.sql》
	
	使用了二级索引 
	
		mysql> desc SELECT name,birthday,phone_number FROM person_info ORDER BY name asc, birthday asc, phone_number asc LIMIT 10;
		+----+-------------+-------------+------------+-------+---------------+--------------------------------+---------+------+------+----------+-------------+
		| id | select_type | table       | partitions | type  | possible_keys | key                            | key_len | ref  | rows | filtered | Extra       |
		+----+-------------+-------------+------------+-------+---------------+--------------------------------+---------+------+------+----------+-------------+
		|  1 | SIMPLE      | person_info | NULL       | index | NULL          | idx_name_birthday_phone_number | 449     | NULL |    9 |   100.00 | Using index |
		+----+-------------+-------------+------------+-------+---------------+--------------------------------+---------+------+------+----------+-------------+
		1 row in set, 1 warning (0.00 sec)

		这个查询的结果集需要先按照name值排序，如果记录的name值相同，则需要按照birthday来排序，如果birthday的值相同，则需要按照phone_number排序。
		
		因为idx_name_birthday_phone_number这个B+树索引本身就是按照上述规则排好序的，所以直接从idx_name_birthday_phone_number索引中提取数据 就好了。

11. 小结

	1. B+树索引在空间和时间上都有代价
	
	2. B+树索引适用于下边这些情况
	
		全值匹配
		匹配左边的列
		匹配范围值
		精确匹配某一列并范围匹配另外一列
		用于排序
		用于分组
		
	3. 在使用索引时需要注意下边这些事项：
	
		只为用于搜索、排序或分组的列创建索引
		为列的基数大的列创建索引
		索引列的类型尽量小
		可以只对字符串值的前缀建立索引
		只有索引列在比较表达式中单独出现才可以适用索引
		为了尽可能少的让聚簇索引发生页面分裂和记录移位的情况，建议让主键拥有AUTO_INCREMENT属性。
		定位并删除表中的重复和冗余索引
		尽量适用覆盖索引进行查询，避免回表带来的性能损耗。	
			
	

	4. 了解索引的内部数据结构，很重要。
	
	
	


