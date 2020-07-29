

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




