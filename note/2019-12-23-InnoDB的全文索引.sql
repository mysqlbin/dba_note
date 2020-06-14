

1. 制造数据
2. 使用全文索引的格式
3. 测试全文索引
4. 配置最小搜索长度
5. 两种全文索引
	自然语言的全文索引
	布尔全文索引
6. 相关参考	
	
	
制造数据
	create table test (
		id int(11) unsigned not null auto_increment,
		content text not null,
		primary key(id),
		fulltext key content_index(content)
	) engine=InnoDB default charset=utf8;

	insert into test (content) values ('a'),('b'),('c');
	insert into test (content) values ('aa'),('bb'),('cc');
	insert into test (content) values ('aaa'),('bbb'),('ccc');
	insert into test (content) values ('aaaa'),('bbbb'),('cccc');
	
	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.01 sec)


使用全文索引的格式
	和常用的模糊匹配使用 like + % 不同，全文索引有自己的语法格式，使用 match 和 against 关键字，比如

	select * from fulltext_test 
		where match(content,tag) against('xxx xxx');

		
测试全文索引	
	mysql> select * from test where match(content) against('a');
	Empty set (0.00 sec)

	mysql> select * from test where match(content) against('aa');
	Empty set (0.00 sec)

	mysql> select * from test where match(content) against('aaa');
	+----+---------+
	| id | content |
	+----+---------+
	|  7 | aaa     |
	+----+---------+
	1 row in set (0.00 sec)

	mysql> select * from test where match(content) against('aaaa');
	+----+---------+
	| id | content |
	+----+---------+
	| 10 | aaaa    |
	+----+---------+
	1 row in set (0.00 sec)

	root@mysqldb 04:40:  [(none)]> show variables like '%innodb_ft_m%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_ft_max_token_size | 84    |
	| innodb_ft_min_token_size | 3     |
	+--------------------------+-------+
	2 rows in set (0.00 sec)

	可以看到最小搜索长度 InnoDB 引擎下是 3，也即，MySQL 的全文索引只会对长度大于等于 3 的词语建立索引，而刚刚搜索的只有 aaa 和 aaaa 的长度大于等于 3。


配置最小搜索长度

	文索引的相关参数都无法进行动态修改，必须通过修改 MySQL 的配置文件来完成。
	修改最小搜索长度的值为 1，首先打开 MySQL 的配置文件 /etc/my.cnf，在 [mysqld] 的下面追加以下内容
	
	[mysqld]
	innodb_ft_min_token_size = 1     # 默认值为3, innodb_ft_min_token_size=1, 表示MySQL 的全文索引只会对长度大于等于 1 的词语建立索引
	ft_min_word_len          = 1     # 默认值为4, ft_min_word_len=1, 表示少于1个字符的单词不会被包含在全文索引里，可以通过修改my.cnf修改选项
	然后重启 MySQL 服务器，并重建表。注意，修改完参数以后，一定要重建表，不然参数不会生效。
	

	root@mysqldb 19:51:  [test_db]> select * from test where match(content) against('a');
	Empty set (0.00 sec)

	root@mysqldb 19:51:  [test_db]> select * from test where match(content) against('aa');
	+----+---------+
	| id | content |
	+----+---------+
	|  4 | aa      |
	+----+---------+
	1 row in set (0.00 sec)

	再次执行上面的查询，aa 就都可以查出来了。
	
	
	但是，这里还有一个问题，搜索关键字 a 时，为什么 aa、aaa、aaaa 没有出现结果中，讲这个问题之前，先说说两种全文索引。

两种全文索引
	自然语言的全文索引
		和常用的模糊匹配使用 like + % 不同，全文索引有自己的语法格式，使用 match 和 against 关键字，比如
			select * from fulltext_test 
				where match(content,tag) against('xxx xxx');
	布尔全文索引
			
			
			mysql> select * from test where match(content) against('a*' in boolean mode);
			+----+---------+
			| id | content |
			+----+---------+
			|  7 | aaa     |
			| 10 | aaaa    |
			+----+---------+
			2 rows in set (0.00 sec)
			
			ft_min_word_len = 1:
				root@mysqldb 19:51:  [test_db]> select * from test where match(content) against('a*' in boolean mode);
				+----+---------+
				| id | content |
				+----+---------+
				|  4 | aa      |
				|  7 | aaa     |
				| 10 | aaaa    |
				+----+---------+
				3 rows in set (0.00 sec)


相关参考
	https://blog.csdn.net/mrzhouxiaofei/article/details/79940958   MySQL 之全文索引
		
	
