

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


idx_name_birthday_phone_number联合索引的索引组织顺序
	
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
		
		
全值匹配

	如果我们的搜索条件中的列和索引列一致的话，这种情况就称为全值匹配
	
	SELECT * FROM person_info WHERE name = 'Ashburn' AND birthday = '1990-09-27' AND phone_number = '15123983239';

	建立的idx_name_birthday_phone_number索引包含的3个列在这个查询语句中都展现出来了
	
	查询过程：
	
		1. 因为B+树的数据页和记录先是按照name列的值进行排序的，所以先可以很快定位name列的值是 Ashburn 的记录位置。

		2. 在name列相同的记录里又是按照birthday列的值进行排序的，所以在name列的值是Ashburn的记录里又可以快速定位birthday列的值是'1990-09-27'的记录。

		3. 如果很不幸，name和birthday列的值都是相同的，那记录是按照phone_number列的值排序的，所以联合索引中的三个列都可能被用到。


	WHERE子句中的几个搜索条件的顺序对查询结果没有影响
	
		也就是说如果我们调换name、birthday、phone_number这几个搜索列的顺序对查询的执行过程是没有影响的。

		SELECT * FROM person_info WHERE birthday = '1990-09-27' AND phone_number = '15123983239' AND name = 'Ashburn';

		原因: MySQL有一个叫查询优化器的东东，会分析这些搜索条件并且按照可以使用的索引中列的顺序来决定先使用哪个搜索条件，后使用哪个搜索条件。
			
		
匹配左边的列

	搜索语句中也可以不用包含全部联合索引中的列，只包含左边的就行，比方说下边的查询语句：
	
		SELECT * FROM person_info WHERE name = 'Ashburn';

	或者包含多个左边的列也行：
	
		SELECT * FROM person_info WHERE name = 'Ashburn' AND birthday = '1990-09-27';

	搜索语句没有匹配左边的列：
	
		SELECT * FROM person_info WHERE birthday = '1990-09-27';
		
		B+树的数据页和记录先是按照name列的值排序的，在name列的值相同的情况下才使用birthday列进行排序，也就是说name列的值不同的记录中birthday的值可能是无序的。
		
		现在你跳过name列直接根据birthday的值去查找，肯定是不用到索引的。
		
	如果我们想使用联合索引中尽可能多的列，搜索条件中的各个列必须是联合索引中从最左边连续的列。	
		
		联合索引idx_name_birthday_phone_number中列的定义顺序是name、birthday、phone_number，如果我们的搜索条件中只有name和phone_number，而没有中间的birthday，比方说这样：	
			
			SELECT * FROM person_info WHERE name = 'Ashburn' AND phone_number = '15123983239';

			这样只能用到name列的索引，birthday和phone_number的索引就用不上了，因为name值相同的记录先按照birthday的值进行排序，birthday值相同的记录才按照phone_number值进行排序。
		
		
匹配列前缀


	为某个列建立索引的意思其实就是在对应的B+树的记录中使用该列的值进行排序    --理解。
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
		
匹配范围值
	
	
样例1
	root@mysqldb 17:49:  [audit_db]> desc SELECT * FROM person_info WHERE name > 'Asa' AND name < 'Barlow';
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
	
		
样例2	

	使用联合进行范围查找，如果对多个列同时进行范围查找的话，只有对索引最左边的那个列进行范围查找的时候才能用到B+树索引
	
	root@mysqldb 17:42:  [audit_db]> desc SELECT * FROM person_info WHERE name > 'Asa' AND name < 'Barlow' AND birthday > '1980-01-01';
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
	

精确匹配某一列并范围匹配另外一列
	
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
			
破坏联合索引的有序性




